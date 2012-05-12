(function() {
  var assert;

  assert = require('assert');

  global.T = function(v) {
    return assert(v);
  };

  global.F = function(v) {
    return assert(!v);
  };

  global.TODO = function(done) {
    console.log("\u001b[35mTODO\u001b[0m");
    return done();
  };

  global.exit = function() {
    return process.exit(arguments);
  };

}).call(this);
