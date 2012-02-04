path = require('path-extra')
fs = require('fs')
require('string')
require('./global')

me = module.exports

me.createTempDir = ->
  name = 'tmpdir-' + Date.now()
  dirName = path.join(path.tempdir(), name)
  fs.mkdirSync(dirName)
  dirName

me.createBuffer = (size) ->
  buf = new Buffer(size)
  bytesWritten = 0
  while bytesWritten < buf.length
    stringOrNum = (Math.random() <= 0.5)
    data = Math.random()
    if stringOrNum
      buf[bytesWritten] = Math.floor((Math.random()*256))
      bytesWritten += 1
    else
      d = data.toString().replace('0.','')
      bytesWritten += buf.write(d.substring(0,4), bytesWritten)
  buf

me.createFileWithData = (filePath, size) ->
  buf = me.createBuffer(size)
  fs.writeFileSync(filePath, buf)
  filePath

me.fetchTestFiles = (dir,callback) ->
  testFiles = []
  file_counter = 1 #starts at one because of the initial directory
  async_running = 0

  again = (current_dir) ->
    fs.lstat current_dir, (err, stat) ->
      if err then file_counter--; return
      if stat.isFile()
        file_counter--
        if current_dir.endsWith('.test.coffee') or current_dir.endsWith('.test.js')
          testFiles.push(current_dir)
      else if stat.isDirectory()
        file_counter--
        async_running++
        fs.readdir current_dir, (err,files) ->
          async_running--
          if err then return #console.log err.message
          file_counter += files.length
          for file in files
            again path.join(current_dir, file)
      else
        file_counter--
      if file_counter is 0 and async_running is 0
        callback(testFiles)

  again dir