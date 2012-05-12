assert = require('assert')

global.T = (v) -> assert(v)
global.F = (v) -> assert(!v)
global.TODO = (done) -> console.log("\u001b[35mTODO\u001b[0m"); done() #prints purple TODO, use with Mocha
global.exit = -> process.exit(arguments) 
 