# Description
#   Lists members of Yamatai.
#
# Dependencies:
#  "htmlparser": "1.7.6"
#  "soupselect": "0.2.0"
#  "cheerio": "0.7.0"
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
cheerio = require("cheerio")

module.exports = (robot) ->
  
  fetchNames = (msg, url) ->
    msg.http(url).get() (err, res, body) ->
      #$ = cheerio.load(body)
      #names = $(
      #response = ""
      #response += 
      handler = new htmlparser.DefaultHandler()
      parser = new htmlparser.Parser(handler)
      parser.parseComplete(body)
      
      response = retrieveNames(handler)
      
      msg.send response
  
  retrieveNames = (handler) ->
    names = Select handler.dom, "div.name"
    response = ""
    response += (name.children[0].raw + "\n") for name in names
    return response
  
  robot.respond /members/i, (msg) ->
    fetchNames(msg, "http://yamatai-taiko.com/members/current/")
  
  robot.respond /alumni/i, (msg) ->
    fetchNames(msg, "http://yamatai-taiko.com/members/alumni/")
      

      
      