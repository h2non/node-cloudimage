# node-cloudimage [![Build Status](https://api.travis-ci.org/h2non/node-cloudimage.svg?branch=master)][travis] [![Dependency Status](https://gemnasium.com/h2non/node-cloudimage.svg)][gemnasium] [![NPM version](https://badge.fury.io/js/node-cloudimage.svg)][npm]

Simple node.js/io.js CLI & programmatic stream-based interface for [Cloudimage.io](https://cloudimage.io)

## Installation

For command-line usage, install is as global package:
```bash
npm install -g cloudimage
```

For programmatic usage, install as tree dependency:
```bash
npm install cloudimage --save[-dev]
```

## CLI

```bash
$ cloudimage --help
```

```bash
Usage: cloudimage [options] [command]

Commands:

  crop [options] [url]           Crop any image to a given square thumbnail in pixels
  width [options] [imageUrl]     Resize any image to a given width in pixels
  height [options] [imageUrl]    Resize the image to the given height in pixels
  resizei [options] [imageUrl]   The image will be resized to fit the given resolution box (but not cropped). White will be added for the padding, if needed
  resizenp [options] [imageUrl]  The image will be resized to fit the given resolution box (but not cropped). No padding will be added here
  cdn [options] [imageUrl]       Cache any image in our worldwide CDN, without any modification of the image

Options:

  -h, --help     output usage information
  -V, --version  output the version number

Examples:

  $ cloudimage crop -r 200x200 http://server.net/image.jpg
  $ cloudimage width -r 300 http://server.net/image.jpg
  $ cloudimage height -r 300 http://server.net/image.jpg
  $ cloudimage resizenp -r 300x200 http://server.net/image.jpg
  $ cloudimage cdn http://server.net/image.jpg
  $ cloudimage crop --id scvy0 http://server.net/image.jpg
  $ cloudimage crop --output test.jpg http://server.net/image.jpg
````

## API

### clouimage(imageUrl)

Constructor of the Cloudimage client

```js
var fs = require('fs')
var Cloudimage = require('cloudimage')

var imageUrl = 'http://bit.ly/1Cqb78Z'

Cloudimage(imageUrl)
  .crop('200x200')
  .on('error', function (err) {
    console.error('Cannot resize the image:', err)
  })
  .pipe(fs.createWriteStream('new-image.jpg'))
```

Use a custom Cloudimage's customer ID:

```js
Cloudimage.clientID = 'svrd10'

Cloudimage(imageUrl)
  .crop('100x100')
  .on('error', function (err) {
    console.error('Cannot resize the image:', err)
  })
  .pipe(fs.createWriteStream('new-image.jpg'))
```

#### cloudimage#crop(resolution)

Crop any image to a given square thumbnail in pixels. Example: `300x300`

#### cloudimage#width(resolution)

Resize any image to a given width in pixels. Example: '200'

#### cloudimage#height(resolution)

Resize any image to a given height in pixels. Example: '200'

#### cloudimage#resizeInBox(resolution)

The image will be resized to fit the given resolution box (but not cropped). White will be added for the padding, if needed.
Example: `300x200`

#### cloudimage#resizeNP(resolution)

The image will be resized to fit the given resolution box (but not cropped). No padding will be added here.
Example: `300x200`

#### cloudimage#cdn()

Cache any image in our worldwide CDN, without any modification of the image.
This will increase the response time in future requests

### cloudimage.VERSION

Get the current module version

## License

[MIT](http://opensource.org/licenses/MIT) © Tomas Aparicio

[travis]: http://travis-ci.org/h2non/node-cloudimage
[gemnasium]: https://gemnasium.com/h2non/node-cloudimage
[npm]: http://npmjs.org/package/node-cloudimage
