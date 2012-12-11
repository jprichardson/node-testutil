var assert = require('assert')

global.T = function(v) {
  return assert(v);
};

global.F = function(v) {
  return assert(!v);
};

global.TTRUE = global.T;

global.TFALSE = global.F;

global.TTrue = global.T;

global.TFalse = global.F;

global.exit = function() {
  return process.exit(arguments);
}

