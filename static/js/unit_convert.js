function meters_to_feet(input){
  return (input*3.28084).toFixed(4);
}

function meters_to_inches(input){
  return (input*39.3701).toFixed(4);
}

function feet_to_meters(input){
  return (input/3.2808).toFixed(4);
}

function feet_to_inches(input){
  return (input*12).toFixed(4);
}

function inches_to_meters(input){
  return (input/39.3701).toFixed(4);
}

function inches_to_feet(input){
  return (input/12).toFixed(4);
}

function mhz_to_meters(input){
  return (299.792458/input).toFixed(4);;
}

function mhz_to_feet(input){
  return (983.571087/input).toFixed(4);
}

function mhz_to_inches(input){
  return (11802.8531/input).toFixed(4);
}
