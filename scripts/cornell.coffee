# Description:
#   Useful hubot script for Yamatai
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
}
module.exports = (robot) ->

  robot.respond /kft hours/i, (msg) ->
    msg.send hours["kft"]
    

  