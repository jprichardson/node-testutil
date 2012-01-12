util = require('testutil')
assert = require('assert')
path = require('path-extra')
fs = require('fs-extra')

T = (v) -> assert(v)
F = (v) -> assert(!v)
log = (s) -> console.log(s)  

describe 'testutil', ->

  describe 'createTempDir', ->
    it 'should create a directory in the OS temp directory', ->
      oldFunc = Date.now
      Date.now = -> 0 #createTempDir uses current unix timestamp to generate directory name

      dirName = path.join(path.tempdir(), 'tmpdir-0')
      if path.existsSync(dirName)
        fs.rmrfSync(dirName)

      dirName2 = util.createTempDir()
      T dirName is dirName2
      T path.existsSync(dirName)

      Date.now = oldFunc #restore it

  describe 'createBuffer', ->
    it 'should create a buffer of size N with random data', ->
      buf = util.createBuffer(10)
      T buf.length is 10

  describe 'createFileWithData', ->
    it 'should create a file specified at by file path filled with random data of size N', ->
      filePath = path.join(path.tempdir(), Date.now() + '')
      if path.existsSync(filePath)
        fs.unlinkSync(filePath)
        
      util.createFileWithData(filePath, 10)
      T path.existsSync(filePath)
        
      buf = fs.readFileSync(filePath)
      T buf.length is 10


 