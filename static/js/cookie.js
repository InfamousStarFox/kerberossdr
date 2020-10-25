// Cookie Library
var cookie = {
  
  // Creates or updates a cookie
  set: function(name, value, date) {
    var expires = null;

    if(date === undefined){
      var d = new Date();
      d.setTime(d.getTime() + (10*365*24*60*60*1000)); // ten years from now
      expires = "expires=" + d.toGMTString();
    }
    else {
      expires = "expires=" + date.toGMTString();
    }
    document.cookie = name + "=" + value + ";" + expires + ";path=/";
  },

  // Returns a cookie value
  get: function(cname) {
    var name = cname + "=";
    var decodedCookie = decodeURIComponent(document.cookie);
    var ca = decodedCookie.split(';');
    for(var i = 0; i < ca.length; i++) {
      var c = ca[i];
      while (c.charAt(0) == ' ') {
        c = c.substring(1);
      }
      if (c.indexOf(name) == 0) {
        return c.substring(name.length, c.length);
      }
    }
    return "";
  },

  // Takes a value, returns 0 if value is empty
  balance: function(value){
    return (value == "") ? 0 : value;
  }
};
