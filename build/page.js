(function() {
  var $, Waller, conf, fs, handlebars, source, template, waller;

  handlebars = require('handlebars');

  Waller = require('./waller');

  fs = require('fs');

  $ = require('jquery');

  conf = JSON.parse(fs.readFileSync('./conf.json', 'utf8'));

  waller = new Waller(conf);

  source = $('#imageTemplate').html();

  template = handlebars.compile(source);

  waller.getUserLikes(waller.likes[0], (function(_this) {
    return function(likes) {
      var result;
      result = template({
        likes: likes
      });
      return $('#container').append(result);
    };
  })(this));

}).call(this);
