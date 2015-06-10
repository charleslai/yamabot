# Description:
#   Useful hubot script for Cornell
#   
# Dependencies:
#   "cheerio": "0.7.0"
#
# Configuration:
#   None
#
# Commands:
#   yamabot cornell - Placeholder
#   yamabot is cornell open - checks university operating status

cheerio = require("cheerio")

hours = {
  kft: "*Kung-fu Tea Hours*: \n
        Mon 1:00 pm - 11:00 pm  \n
        Tue 1:00 pm - 11:00 pm  \n
        Wed 1:00 pm - 11:00 pm  \n
        Thu 1:00 pm - 11:00 pm  \n
        Fri 1:00 pm - 12:00 am  \n
        Sat 1:00 pm - 12:00 am  \n
        Sun 1:00 pm - 11:00 pm"

  oth: "*Old Teahouse Hours*: \n
        Mon 11:00 am - 12:00 am \n
        Tue 11:00 am - 12:00 am \n
        Wed 11:00 am - 12:00 am \n
        Thu 11:00 am - 2:00 am \n
        Fri 11:00 am - 2:00 am \n 
        Sat 12:00 pm - 12:00 am \n
        Sun 12:00 pm - 12:00 am "

  chipotle: "*Chipotle Hours*: \n
             Mon 11:00 am – 10:00 pm \n
             Tue 11:00 am – 10:00 pm \n
             Wed 11:00 am – 10:00 pm \n
             Thu 11:00 am – 10:00 pm \n
             Fri 11:00 am – 10:00 pm \n
             Sat 11:00 am – 10:00 pm \n
             Sun 11:00 am – 10:00 pm"
}

module.exports = (robot) ->

  # Restaurant Hours =================
  robot.respond /kft hours/i, (msg) ->
    msg.send hours["kft"]

  robot.respond /oth hours/i, (msg) ->
    msg.send hours["oth"]

  robot.respond /chipotle hours/i, (msg) ->
    msg.send hours["chipotle"]
    
  # Operating status =================
  robot.respond /is cornell open/i, (msg) ->
    msg.http("http://www.cornell.edu/status/").get() (err, res, body) ->
      $ = cheerio.load(body)
      if res.statusCode != 200
        msg.send "I can't connect to the Cornell website right now."
      else
        msg.send $('h2.pagetitle').text()



  