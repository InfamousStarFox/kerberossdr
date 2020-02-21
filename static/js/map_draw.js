// bearings recorded latitude, longitude, bearing degrees
// var bearings = [{ freq: 104.1, time: 1578610965, lat: 48.00, lgn: -122.00, dgr: 45 }]
var bearings = [
  { lat: 48.8204, lgn: -122.5723, dgr: 0 },
  { lat: 48.8204, lgn: -122.5723, dgr: 45 },
  { lat: 48.8204, lgn: -122.5723, dgr: 270 },
];

var mymap = null;
var marker = null;
var position = null;
var lines = [];
var initalized = false;

function init_map(freq){
  if (navigator.geolocation) {
    navigator.geolocation.watchPosition(function(new_position){
      position = new_position;

      if(initalized){
        // Update map with new marker locations
        update_marker();
      }
      else {
        // Create the map
        var myLocation = [position.coords.latitude, position.coords.longitude];
        mymap = L.map('mapid').setView(myLocation, 15);
        L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}', {
          maxZoom: 18,
          attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
          id: 'mapbox/streets-v11',
          accessToken: 'pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw'
        }).addTo(mymap);

        // Add a pin with the current location
        marker = L.marker(myLocation).addTo(mymap);

        // Add previous bearings to the map
        for(let i=0; i<bearings.length; i++){
          addLine(bearings[i], 5000, "red");
        }
        initalized = true;
      }
    });
  }
}

function update_marker(){
  // Remove the old marker
  if (mymap.hasLayer(marker)) {
    mymap.removeLayer(marker);
  }
  // Add a new marker
  marker = L.marker([position.coords.latitude, position.coords.longitude]).addTo(mymap);
}


function map_bearing(bearing){
  if(initalized && navigator.geolocation) {
    if(position.coords.heading){
      var heading = position.coords.heading;
      var direction = {
        lat: position.coords.latitude,
        lgn: position.coords.longitude,
        dgr: Number(heading) + Number(bearing),
      };
      addLine(direction, 5000, "yellow");
    }
    // For testing purposes only
    // Delete else for production
    else{
      var heading = 0;
      var direction = {
        lat: position.coords.latitude,
        lgn: position.coords.longitude,
        dgr: Number(heading) + Number(bearing),
      };
      addLine(direction, 5000, "blue");
    }
  }
}

function addLine(direction, distance, color){
  var source = [direction.lat, direction.lgn];
  var dest = destVincenty(direction.lat, direction.lgn, direction.dgr, distance);

  var line = L.polygon([
    source,
    dest
  ]);
  
  line.setStyle({
      color: color,
      opacity: 0.2
  });

  mymap.addLayer(line);
  lines.push(line);
}

/*
function removeLine(line){
  if (mymap.hasLayer(line)) {
    mymap.removeLayer(line);
  }
}
*/


/*!
* JavaScript function to calculate the destination point given start point latitude / longitude (numeric degrees), bearing (numeric degrees) and distance (in m).
*
* Original scripts by Chris Veness
* Taken from http://movable-type.co.uk/scripts/latlong-vincenty-direct.html and optimized / cleaned up by Mathias Bynens <http://mathiasbynens.be/>
* Based on the Vincenty direct formula by T. Vincenty, “Direct and Inverse Solutions of Geodesics on the Ellipsoid with application of nested equations”, Survey Review, vol XXII no 176, 1975 <http://www.ngs.noaa.gov/PUBS_LIB/inverse.pdf>
*/
function destVincenty(lat1, lon1, brng, dist) {
  var a = 6378137,
  b = 6356752.3142,
  f = 1 / 298.257223563, // WGS-84 ellipsiod
  s = dist,
  alpha1 = toRad(brng),
  sinAlpha1 = Math.sin(alpha1),
  cosAlpha1 = Math.cos(alpha1),
  tanU1 = (1 - f) * Math.tan(toRad(lat1)),
  cosU1 = 1 / Math.sqrt((1 + tanU1 * tanU1)), sinU1 = tanU1 * cosU1,
  sigma1 = Math.atan2(tanU1, cosAlpha1),
  sinAlpha = cosU1 * sinAlpha1,
  cosSqAlpha = 1 - sinAlpha * sinAlpha,
  uSq = cosSqAlpha * (a * a - b * b) / (b * b),
  A = 1 + uSq / 16384 * (4096 + uSq * (-768 + uSq * (320 - 175 * uSq))),
  B = uSq / 1024 * (256 + uSq * (-128 + uSq * (74 - 47 * uSq))),
  sigma = s / (b * A),
  sigmaP = 2 * Math.PI;
  while (Math.abs(sigma - sigmaP) > 1e-12) {
    var cos2SigmaM = Math.cos(2 * sigma1 + sigma),
    sinSigma = Math.sin(sigma),
    cosSigma = Math.cos(sigma),
    deltaSigma = B * sinSigma * (cos2SigmaM + B / 4 * (cosSigma * (-1 + 2 * cos2SigmaM * cos2SigmaM) - B / 6 * cos2SigmaM * (-3 + 4 * sinSigma * sinSigma) * (-3 + 4 * cos2SigmaM * cos2SigmaM)));
    sigmaP = sigma;
    sigma = s / (b * A) + deltaSigma;
  };
  var tmp = sinU1 * sinSigma - cosU1 * cosSigma * cosAlpha1,
  lat2 = Math.atan2(sinU1 * cosSigma + cosU1 * sinSigma * cosAlpha1, (1 - f) * Math.sqrt(sinAlpha * sinAlpha + tmp * tmp)),
  lambda = Math.atan2(sinSigma * sinAlpha1, cosU1 * cosSigma - sinU1 * sinSigma * cosAlpha1),
  C = f / 16 * cosSqAlpha * (4 + f * (4 - 3 * cosSqAlpha)),
  L = lambda - (1 - C) * f * sinAlpha * (sigma + C * sinSigma * (cos2SigmaM + C * cosSigma * (-1 + 2 * cos2SigmaM * cos2SigmaM))),
  revAz = Math.atan2(sinAlpha, -tmp); // final bearing
  return [toDeg(lat2), lon1 + toDeg(L)];
};
function toRad(n) {
  return n * Math.PI / 180;
};
function toDeg(n) {
  return n * 180 / Math.PI;
};