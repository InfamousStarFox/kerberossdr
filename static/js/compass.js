// Compass Library
var compass = {

  // User defined values
  MIN_PWR: 0,
  MIN_CONF: 0,
  OFFSET: 0,

  // Calculated values
  DOA_deg: 0,
  PWR_val: 0,
  CONF_val: 0,

  // Initalize the compass canvas
  init: function() {
    // Set the min power and confidence
    compass.cookie.get();

    // Grab the compass element
    var canvas = document.getElementById('compass');
    var size = getSize();
    var scale = size/800;
    var first_entry = 1;

    // Initalize blank compass image
    var img = null;
    var needle = null;
    var ctx = null;

    canvas.width = size;
    canvas.height = size;

    // Is Canvas supported?
    if (canvas.getContext('2d')) {
      ctx = canvas.getContext('2d');
      ctx.scale(scale, scale, scale);

      // Load the needle image
      needle = new Image();
      needle.src = '/static/images/arrow.png';

      // Load the compass image
      img = new Image();
      img.src = '/static/images/hydra_compass.png';
      img.onload = imgLoaded;
    } else {
      alert("Canvas not supported!");
    }

    // Calls draw() every 100 milliseconds
    function imgLoaded() {
      // Image loaded event complete.  Start the timer
      setInterval(draw(img, needle, ctx), 100);
    }

    // Get the size of the canvas
    function getSize() {
      // Body has 8px of padding on each side
      var width = window.innerWidth - 16;
      var height = window.innerHeight - 16;

      // Canvas width & height = 100%
      // Max-width & max-height = 800px
      var size = Math.min(width, height, 800);

      return size;
    }


    // Draw the compass onto the canvas
    function draw(img, needle, ctx) {

      // Uses the ajaxpage.js library
      ajaxpage('/static/DOA_value.html', pageLoaded);

      if ((compass.PWR_val >= compass.MIN_PWR && compass.CONF_val >= compass.MIN_CONF) || first_entry == 1) {
        first_entry = 0;
        clearCanvas();

        // Draw the compass onto the canvas
        ctx.drawImage(img, 0, 0);

        // Save the current drawing state
        ctx.save();

        // Now move across and down half the
        ctx.translate(400, 400);  // Set to canvas size/2

        //degrees=45
        // Rotate around this point
        ctx.rotate(compass.DOA_deg * (Math.PI / 180));

        // Draw the image back and up
        ctx.drawImage(needle, -45, -400); // Set to arrow size/2

        // Restore the previous drawing state
        ctx.restore();

        // Uses the map_draw.js library
        map_bearing(compass.DOA_deg);
      }

      document.getElementById("doa").innerHTML = compass.DOA_deg;
      document.getElementById("pwr").innerHTML = Math.round(compass.PWR_val*100)/100;
      document.getElementById("conf").innerHTML = compass.CONF_val;

      function clearCanvas() {
        // clear canvas
        ctx.clearRect(0, 0, 800, 800);
      }

      function pageLoaded(myRequest){
        var response = myRequest.responseText; // Has the form of <DOA>..</DOA>
        response = "<DATA>" + response + "</DATA>";
        var xml = parseXml(response);

        if(xml.getElementsByTagName("DOA").length != 0){
          compass.DOA_deg = 360 - Number(xml.getElementsByTagName("DOA")[0].childNodes[0].nodeValue);
        }
        if(xml.getElementsByTagName("PWR").length !=0){
          compass.PWR_val = Math.max((Number(xml.getElementsByTagName("PWR")[0].childNodes[0].nodeValue)), 0);
        }
        if(xml.getElementsByTagName("CONF").length !=0){
          compass.CONF_val = Math.max((Number(xml.getElementsByTagName("CONF")[0].childNodes[0].nodeValue)), 0);
        }
      }
    }
  },

  // Extends the cookie.js library
  cookie: {
    set: function() {
      cookie.set("MIN_PWR", document.getElementById('MIN_PWR').value);
      cookie.set("MIN_CONF", document.getElementById('MIN_CONF').value);
      cookie.set("OFFSET", document.getElementById('OFFSET').value);
    },
    get: function() {
      compass.MIN_PWR = cookie.balance(cookie.get("MIN_PWR"));
      compass.MIN_CONF = cookie.balance(cookie.get("MIN_CONF"));
      compass.OFFSET = cookie.balance(cookie.get("OFFSET"));
      document.getElementById("MIN_PWR").value = compass.MIN_PWR;
      document.getElementById("MIN_CONF").value = compass.MIN_CONF;
      document.getElementById("OFFSET").value = compass.OFFSET;
    },
  },
};
