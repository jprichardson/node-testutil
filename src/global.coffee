assert = require('assert')

global.T = (v) -> assert(v)
global.F = (v) -> assert(!v)
global.TTRUE = global.T
global.TFALSE = global.F
global.TTrue = global.T
global.TFalse = global.F
global.exit = -> process.exit(arguments) 
 