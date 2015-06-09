# Description:
#   Useful hubot script for Cornell
#   
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   yamabot cornell - Placeholder

hours = {
  kft: "Kung-fu Tea Hours: \n
        Mon 1:00 pm - 11:00 pm  \n
        Tue 1:00 pm - 11:00 pm  \n
        Wed 1:00 pm - 11:00 pm  \n
        Thu 1:00 pm - 11:00 pm  \n
        Fri 1:00 pm - 12:00 am  \n
        Sat 1:00 pm - 12:00 am  \n
        Sun 1:00 pm - 11:00 pm"

  oth: "Old Teahouse Hours: \n
        Mon 11:00 am - 12:00 am \n
        Tue 11:00 am - 12:00 am \n
        Wed 11:00 am - 12:00 am \n
        Thu 11:00 am - 2:00 am \n
        Fri 11:00 am - 2:00 am \n 
        Sat 12:00 pm - 12:00 am \n
        Sun 12:00 pm - 12:00 am "

  chipotle: "Chipotle Hours: \n
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



  