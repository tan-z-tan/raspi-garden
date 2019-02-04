fs = require "fs"
exec = require('child-process-promise').exec;
{WebClient} = require "@slack/client"

filename = "photo.jpg"
command = "fswebcam -r 1280x960 --no-info --no-overlay --no-timestamp --no-banner --jpeg 95q /tmp/#{filename}"

module.exports = (robot) ->
  web = new WebClient robot.adapter.options.token

  robot.hear /写真/i, (res) ->
    exec(command)
      .then (result) ->
        web.files.upload({
          filename: filename,
          title: filename,
          file: fs.createReadStream("/tmp/#{filename}"),
          channels: res.message.room
        })
          .then (resp) ->
            robot.logger.debug "Received message #{resp.file.id}"
          .catch (error) ->
            res.send error.message
      .catch (error) ->
        res.send error.stderr
