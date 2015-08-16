(function() {
  var Waller, artwork, base, collections, fs, likes, request, users;

  request = require('request');

  fs = require('fs');

  base = "https://www.artstation.com/";

  artwork = "projects/";

  collections = "collections/";

  users = "users/";

  likes = "/likes.json";

  module.exports = Waller = (function() {
    function Waller(config) {
      this.likes = config.likes;
      this.savePath = config.savePath;
      this.collections = config.collections;
      this.debug = config.debug;
    }

    Waller.prototype.getJson = function(url, callback) {
      return request({
        url: url,
        json: true
      }, function(err, resp, body) {
        return callback(body);
      });
    };

    Waller.prototype.getUserLikes = function(user, callback) {
      return this.getJson(base + users + user + likes, (function(_this) {
        return function(resp) {
          return callback(resp.data);
        };
      })(this));
    };

    Waller.prototype.downloadUserLikes = function(user) {
      return this.getJson(base + users + user + likes, (function(_this) {
        return function(resp) {
          var i, len, like, ref, results;
          if (_this.debug) {
            console.log(resp);
          }
          ref = resp.data;
          results = [];
          for (i = 0, len = ref.length; i < len; i++) {
            like = ref[i];
            results.push(_this.getJson(base + artwork + like.slug + '.json', function(json) {
              var req;
              req = request(json.assets[0].image_url);
              json.title = json.title.replace(/\/|\\/g, "-");
              console.log('Saving image: ' + json.title);
              return req.pipe(fs.createWriteStream(_this.savePath + '\\' + json.title + '.jpg'));
            }));
          }
          return results;
        };
      })(this));
    };

    Waller.prototype.downloadAllUserLikes = function() {
      var i, len, like, ref, results;
      ref = this.likes;
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        like = ref[i];
        results.push(this.downloadUserLikes(like));
      }
      return results;
    };

    return Waller;

  })();

}).call(this);
