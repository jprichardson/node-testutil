assert = require('assert')

global.T = (v) -> assert(v)
global.F = (v) -> assert(!v)
global.exit = -> process.exit(arguments) 
 