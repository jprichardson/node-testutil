(function() {
  var endsWith, fs, me, path;

  path = require('path-extra');

  fs = require('fs');

  require('./global');

  endsWith = function(s, suffix) {
    var l;
    l = s.length - suffix.length;
    return l >= 0 && s.indexOf(suffix, l) === l;
  };

  me = module.exports;

  me.createTempDir = function() {
    var dirName, name;
    name = 'tmpdir-' + Date.now();
    dirName = path.join(path.tempdir(), name);
    fs.mkdirSync(dirName);
    return dirName;
  };

  me.createBuffer = function(size) {
    var buf, bytesWritten, d, data, stringOrNum;
    buf = new Buffer(size);
    bytesWritten = 0;
    while (bytesWritten < buf.length) {
      stringOrNum = Math.random() <= 0.5;
      data = Math.random();
      if (stringOrNum) {
        buf[bytesWritten] = Math.floor(Math.random() * 256);
        bytesWritten += 1;
      } else {
        d = data.toString().replace('0.', '');
        bytesWritten += buf.write(d.substring(0, 4), bytesWritten);
      }
    }
    return buf;
  };

  me.createFileWithData = function(filePath, size) {
    var buf;
    buf = me.createBuffer(size);
    fs.writeFileSync(filePath, buf);
    return filePath;
  };

  me.fetchTestFiles = function(dir, callback) {
    var again, async_running, file_counter, testFiles;
    testFiles = [];
    file_counter = 1;
    async_running = 0;
    again = function(current_dir) {
      return fs.lstat(current_dir, function(err, stat) {
        if (err) {
          file_counter--;
          return;
        }
        if (stat.isFile()) {
          file_counter--;
          if (endsWith(current_dir, '.test.coffee') || endsWith(current_dir, '.test.js')) {
            testFiles.push(current_dir);
          }
        } else if (stat.isDirectory()) {
          file_counter--;
          async_running++;
          fs.readdir(current_dir, function(err, files) {
            var file, _i, _len, _results;
            async_running--;
            if (err) return;
            file_counter += files.length;
            _results = [];
            for (_i = 0, _len = files.length; _i < _len; _i++) {
              file = files[_i];
              _results.push(again(path.join(current_dir, file)));
            }
            return _results;
          });
        } else {
          file_counter--;
        }
        if (file_counter === 0 && async_running === 0) return callback(testFiles);
      });
    };
    return again(dir);
  };

}).call(this);
