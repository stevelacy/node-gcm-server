mongoose = require "mongoose"
Schema = mongoose.Schema

Device = new Schema
  gcmId:
    type: String
    required: true
  event:
    type: String


Device.set "autoindex", false

module.exports = Device
