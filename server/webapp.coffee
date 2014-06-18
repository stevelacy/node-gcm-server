passport = require "./passport"
config = require "../config"
app = require "./express"
db = require "./db"

Device = db.models.Device


app.get "/", (req, res) ->
  Device.find {}, (err, devices) ->
    res.render "index", user: req.user, items: devices

app.get "/logout", (req, res) ->
  req.logout()
  res.redirect "/"

app.get "/login", (req, res) ->
  return res.redirect "/" if req.user?
  res.render "login"


app.get "/auth/twitter", passport.authenticate "twitter"
app.get "/auth/twitter/callback",
  passport.authenticate "twitter",
    successRedirect:"/"
    falureRedirect:"/login"



## Android GCM
app.post "/gcm", (req, res) ->
  res.send 204
  #console.log req.body, req.params
  Device.findOne {gcmId: req.body.id}, (err, device) ->
    console.log err if err?
    return device if device
    newDevice = new Device()
    deviceData =
      gcmId: req.body.id
    newDevice.set deviceData
    newDevice.save (err, data) ->
      return console.log err if err?
      console.log data
