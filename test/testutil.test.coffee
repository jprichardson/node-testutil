testutil = require('testutil')
path = require('path-extra')
fs = require('fs-extra')
rimraf = require('rimraf')

if fs.existsSync == undefined
  fs.existsSync = path.existsSync

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
      if fs.existsSync(dirName)
        fs.removeSync(dirName)

      dirName2 = testutil.createTempDir()
      T dirName is dirName2
      T fs.existsSync(dirName)

      Date.now = oldFunc #restore it

  describe '+ createBuffer()', ->
    it 'should create a buffer of size N with random data', ->
      buf = testutil.createBuffer(10)
      T buf.length is 10

  describe '+ createFileWithData()', ->
    it 'should create a file specified at by file path filled with random data of size N', ->
      filePath = path.join(path.tempdir(), Date.now() + '')
      if fs.existsSync(filePath)
        fs.unlinkSync(filePath)
        
      testutil.createFileWithData(filePath, 10)
      T fs.existsSync(filePath)
        
      buf = fs.readFileSync(filePath)
      T buf.length is 10

    it '+ should return the file path of the file created()', ->
      filePath = path.join(path.tempdir(), Date.now() + '')
      if fs.existsSync(filePath)
        fs.unlinkSync(filePath)
        
      filePath2 = testutil.createFileWithData(filePath, 10)
      T filePath2 is filePath

  describe '+ fetchTestFiles()', ->
    it 'should return the test files in the specified directory', (done) ->
      testutil.fetchTestFiles './', (files) ->
        T endsWith(files[0], 'testutil.test.coffee')
        done()

  describe '+ createTestDir()', ->
    describe '  when it doesnt exist', ->
      it 'should create a test dir', ->
        dir = path.join(path.tempdir(), 'test-myapp')
        if fs.existsSync(dir)
          rimraf.sync(dir)
        F fs.existsSync(dir)
        testutil.createTestDir('myapp')
        T fs.existsSync(dir)
    describe '  when it exists', ->
      it 'should delete the dir and create it', ->
        dir = path.join(path.tempdir(), 'test-myapp')
        if not fs.existsSync(dir)
          fs.mkdirSync(dir)
        T fs.existsSync(dir)
        testutil.createTestDir('myapp')
        T fs.existsSync(dir)        














 