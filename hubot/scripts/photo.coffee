fs = require "fs"
{WebClient} = require "@slack/client"

filename = "lena.png"

module.exports = (robot) ->
  web = new WebClient robot.adapter.options.token
  console.log(process.cwd())

  robot.hear /写真/i, (res) ->
    web.files.upload({
      filename: filename,
      title: filename,
      file: fs.createReadStream("/tmp/lena.png"),
      channels: res.message.room
    })
      .then (resp) ->
        robot.logger.debug "Received message #{resp.file.id}"
      .catch (error) ->
        res.send error.message

