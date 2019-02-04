fs = require "fs"
{WebClient} = require "@slack/client"

filename = "screenshot.jpg"

module.exports = (robot) ->
  web = new WebClient robot.adapter.options.token
  console.log(process.cwd())

  robot.hear /写真/i, (res) ->
    web.files.upload({
      filename: filename,
      title: filename,
      file: fs.createReadStream("/tmp/screenshot.jpg"),
      channels: res.message.room
    })
      .then (resp) ->
        robot.logger.debug "Received message #{resp.file.id}"
      .catch (error) ->
        res.send error.message

