var request = require('request')
var Client = require('./client')
var pkg = require('../package.json')

module.exports = Cloudimage

function Cloudimage(url) {
  return new Client(url, Cloudimage.clientId)
}

Cloudimage.clientId = 'demo05'
Cloudimage.Client = Client
Cloudimage.VERSION = pkg.version
