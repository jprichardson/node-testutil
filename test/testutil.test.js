var testutil = require('testutil')
  , path = require('path-extra')
  , fs = require('fs-extra')
  , rimraf = require('rimraf');

if (!fs.existsSync) fs.existsSync = path.existsSync

log = function(s) {
  return console.log(s);
};

endsWith = function(s, suffix) {
  var l;
  l = s.length - suffix.length;
  return l >= 0 && s.indexOf(suffix, l) === l;
};

describe('testutil', function() {
  describe('+ createTempDir()', function() {
    return it('should create a directory in the OS temp directory', function() {
      var dirName, dirName2, oldFunc;
      oldFunc = Date.now;
      Date.now = function() {
        return 0;
      };
      dirName = path.join(path.tempdir(), 'tmpdir-0');
      if (fs.existsSync(dirName)) {
        fs.removeSync(dirName);
      }
      dirName2 = testutil.createTempDir();
      T(dirName === dirName2);
      T(fs.existsSync(dirName));
      return Date.now = oldFunc;
    });
  });
  describe('+ createBuffer()', function() {
    return it('should create a buffer of size N with random data', function() {
      var buf;
      buf = testutil.createBuffer(10);
      return T(buf.length === 10);
    });
  });
  describe('+ createFileWithData()', function() {
    it('should create a file specified at by file path filled with random data of size N', function() {
      var buf, filePath;
      filePath = path.join(path.tempdir(), Date.now() + '');
      if (fs.existsSync(filePath)) {
        fs.unlinkSync(filePath);
      }
      testutil.createFileWithData(filePath, 10);
      T(fs.existsSync(filePath));
      buf = fs.readFileSync(filePath);
      return T(buf.length === 10);
    });
    return it('+ should return the file path of the file created()', function() {
      var filePath, filePath2;
      filePath = path.join(path.tempdir(), Date.now() + '');
      if (fs.existsSync(filePath)) {
        fs.unlinkSync(filePath);
      }
      filePath2 = testutil.createFileWithData(filePath, 10);
      return T(filePath2 === filePath);
    });
  });
  describe('+ fetchTestFiles()', function() {
    return it('should return the test files in the specified directory', function(done) {
      return testutil.fetchTestFiles('./', function(files) {
        T(endsWith(files[0], 'testutil.test.js'));
        return done();
      });
    });
  });
  return describe('+ createTestDir()', function() {
    describe('> when it doesnt exist', function() {
      return it('should create a test dir', function() {
        var dir;
        dir = path.join(path.tempdir(), 'test-myapp');
        if (fs.existsSync(dir)) {
          rimraf.sync(dir);
        }
        F(fs.existsSync(dir));
        testutil.createTestDir('myapp');
        return T(fs.existsSync(dir));
      });
    });
    return describe('> when it exists', function() {
      return it('should delete the dir and create it', function() {
        var dir;
        dir = path.join(path.tempdir(), 'test-myapp');
        rimraf.sync(dir);
        fs.mkdirsSync(dir);
        fs.writeFileSync(path.join(dir, 'blah'), 'afafaf');
        T(fs.existsSync(dir));
        testutil.createTestDir('myapp');
        T(fs.existsSync(dir));
        return T(fs.readdirSync(dir).length === 0);
      });
    });
  });
});


