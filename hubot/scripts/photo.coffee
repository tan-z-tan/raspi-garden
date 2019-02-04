fs = require "fs"
exec = require('child_process').exec;
{WebClient} = require "@slack/client"

filename = "photo.jpg"

module.exports = (robot) ->
  web = new WebClient robot.adapter.options.token
  console.log(process.cwd())

  robot.hear /写真/i, (res) ->
    exec("fswebcam -r 1280x960 --no-info --no-overlay --no-timestamp --no-banner --jpeg 95q /tmp/photo.jpg")
      .then () ->
        web.files.upload({
          filename: filename,
          title: filename,
          file: fs.createReadStream("/tmp/photo.jpg"),
          channels: res.message.room
        })
          .then (resp) ->
            robot.logger.debug "Received message #{resp.file.id}"
          .catch (error) ->
            res.send error.message
      .catch (error) ->
        robot.logger.debug "Received message #{resp.file.id}"
