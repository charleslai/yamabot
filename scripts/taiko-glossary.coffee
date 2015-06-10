# Description
#   Defines taiko terminology from TaikoSource glossary.
#
# Dependencies:
#  "cheerio": "0.7.0"
#
# Configuration:
#   None
#
# Commands:
#   yamabot define <term> - fetches definition
#
# Author:
#   nyanya

cheerio = require("cheerio")

module.exports = (robot) ->
  
  fetchDefinition = (msg, url) ->
    msg.http(url).get() (err, res, body) ->
      if res.statusCode != 200
        msg.send "I don't know that term. Ask Ananya."
      else
        $ = cheerio.load(body)
        msg.send $('div.entry-content').text()
  
  robot.respond /define\s([a-zA-Z]+(\s?[a-zA-z])*)/i, (msg) ->
    query = msg.match[1].split(" ").join("-")
    fetchDefinition(msg, "http://taikosource.com/glossary/#{query}/")