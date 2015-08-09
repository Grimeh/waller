(function() {
  var conf, fs, time, wall, waller;

  waller = require('./waller.js');

  fs = require('fs');

  conf = JSON.parse(fs.readFileSync('./conf.json', 'utf8'));

  wall = new waller(conf);

  wall.downloadAllUserLikes();

  time = conf.timer != null ? conf.timer : -1;

  if (time === -1 || time === 0) {
    console.log("CONF.TIME NOT SET, RUNNING ONCE");
    return;
  } else {
    setInterval((function(_this) {
      return function() {
        return wall.downloadAllUserLikes();
      };
    })(this), time * 1000);
  }

}).call(this);
