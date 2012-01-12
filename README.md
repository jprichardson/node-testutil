# Node.js: testutil

This module provides methods to aid in testing your Node.js apps.

## Installation

    npm install testutil

Make sure that you run the test script to verify that it works on your system.
Navigate to the directory for the module and run: `make test`

## Usage

```javascript
util = require('testutil')
```

## Methods

```javascript
util.createTempDir() //creates a temporary directory in the OS temporary directory. e.g. /tmp/tmpdir-359353928528529/
buf = util.createBuffer(size) //creates a Buffer filled with random data
filePath = createFileWithData(filePath, size) //creates a file filled with random data 
```

## License

(The MIT License)

Copyright (c) 2011 JP Richardson
