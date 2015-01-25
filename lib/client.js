var request = require('request')

module.exports = Cloudimage

function Cloudimage(url, id) {
  this.imageUrl = url
  this.baseUrl = id + Cloudimage.serverUrl
}

Cloudimage.serverUrl = '.cloudimage.io/s'

Cloudimage.prototype.crop = function (resolution) {
  return request(this.url('crop', resolution))
}

Cloudimage.prototype.width = function (resolution) {
  return request(this.url('width', resolution))
}

Cloudimage.prototype.height = function (resolution) {
  return request(this.url('height', resolution))
}

Cloudimage.prototype.resizeInBox = function (resolution) {
  return request(this.url('resizeinbox', resolution))
}

Cloudimage.prototype.resizeNP = function (resolution) {
  return request(this.url('resizenp', resolution))
}

Cloudimage.prototype.cdn = function () {
  return request(this.url('cdn'))
}

Cloudimage.prototype.url = function (action, params) {
  return 'http://' + this.baseUrl + '/' + action + '/' + (params || 'x') + '/' + this.imageUrl
}
