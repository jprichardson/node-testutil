testutil = require('testutil')
path = require('path-extra')
fs = require('fs-extra')

log = (s) -> console.log(s)  

endsWith = (s, suffix) ->
  l = s.length - suffix.length;
  l >= 0 && s.indexOf(suffix, l) == l;

describe 'testutil', ->
  describe '+ createTempDir()', ->
    it 'should create a directory in the OS temp directory', ->
      oldFunc = Date.now
      Date.now = -> 0 #createTempDir uses current unix timestamp to generate directory name

      dirName = path.join(path.tempdir(), 'tmpdir-0')
      if path.existsSync(dirName)
        fs.rmrfSync(dirName)

      dirName2 = testutil.createTempDir()
      T dirName is dirName2
      T path.existsSync(dirName)

      Date.now = oldFunc #restore it

  describe '+ createBuffer()', ->
    it 'should create a buffer of size N with random data', ->
      buf = testutil.createBuffer(10)
      T buf.length is 10

  describe '+ createFileWithData()', ->
    it 'should create a file specified at by file path filled with random data of size N', ->
      filePath = path.join(path.tempdir(), Date.now() + '')
      if path.existsSync(filePath)
        fs.unlinkSync(filePath)
        
      testutil.createFileWithData(filePath, 10)
      T path.existsSync(filePath)
        
      buf = fs.readFileSync(filePath)
      T buf.length is 10

    it '+ should return the file path of the file created()', ->
      filePath = path.join(path.tempdir(), Date.now() + '')
      if path.existsSync(filePath)
        fs.unlinkSync(filePath)
        
      filePath2 = testutil.createFileWithData(filePath, 10)
      T filePath2 is filePath

  describe '+ fetchTestFiles()', ->
    it 'should return the test files in the specified directory', (done) ->
      testutil.fetchTestFiles './', (files) ->
        T endsWith(files[0], 'testutil.test.coffee')
        done()


 