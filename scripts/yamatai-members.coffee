# Description
#   Lists members of Yamatai.
#
# Dependencies:
#  "htmlparser": "1.7.6"
#  "soupselect": "0.2.0"
#
# Configuration:
#   None
#
# Commands:
#   yamabot members - list members
#
# Author:
#   nyanya

htmlparser = require "htmlparser"
Select = require("soupselect").select

module.exports = (robot) ->
  robot.respond /members/i, (msg) ->
    msg.http("http://yamatai-taiko.com/members/current/").get() (err, res, body) ->
      handler = new htmlparser.DefaultHandler()
      parser = new htmlparser.Parser(handler)
      parser.parseComplete(body)
      
      members = Select handler.dom, "name"
      response = ""
      response += member + "\n" for member in members

      msg.send response
      