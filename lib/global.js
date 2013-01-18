var assert = require('assert')

global.T = function(v) {
  assert(v);
}

global.F = function(v) {
  assert(!v);
}

global.exit = function() {
  process.exit(arguments);
}

