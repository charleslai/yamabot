# Description
#   Attempt at breaking Slack.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   yamabot troll - replies with troll
#
# Author:
#   nyanya

module.exports = (robot) ->
  robot.respond /troll/i, (msg) ->
    callback = -> msg.send "troll"
    setTimeout callback, 1000