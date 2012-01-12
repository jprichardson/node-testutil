path = require('path-extra')
fs = require('fs')

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


