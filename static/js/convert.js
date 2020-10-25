// Convert Library
var convert = {
  meters: {
    toFeet: function(input){
      return (input*3.28084).toFixed(4);
    },
    toInches: function(input){
      return (input*39.3701).toFixed(4);
    }
  },
  feet: {
    toMeters: function(input){
      return (input/3.2808).toFixed(4);
    },
    toInches: function(input){
      return (input*12).toFixed(4);
    }
  },
  inches: {
    toMeters: function(input){
      return (input/39.3701).toFixed(4);
    },
    toFeet: function(input){
      return (input/12).toFixed(4);
    }
  },
  mhz: {
    toMeters: function(input){
      return (299.792458/input).toFixed(4);
    },
    toFeet: function(input){
      return (983.571087/input).toFixed(4);
    },
    toInches: function(input){
      return (11802.8531/input).toFixed(4);
    }
  }
};
