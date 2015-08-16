(function() {
  var BrowserWindow, Waller, app, conf, fs, waller, window;

  app = require('app');

  BrowserWindow = require('browser-window');

  fs = require('fs');

  Waller = require('./waller');

  require('crash-reporter').start();

  conf = JSON.parse(fs.readFileSync('./conf.json', 'utf8'));

  waller = new Waller(conf);

  window = null;

  app.on('windows-all-closed', function() {
    return app.quit();
  });

  app.on('ready', function() {
    window = new BrowserWindow({
      width: 800,
      height: 600
    });
    window.loadUrl('file://' + __dirname + '/index.html');
    return window.on('closed', function() {
      return window = null;
    });
  });

}).call(this);
