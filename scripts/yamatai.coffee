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
#   yamabot mcnanny - Recieve a mcnanny

imgs = {
  mcnanny: "imgur link here"
}


module.exports = (robot) ->
  
  # Specific Images
  robot.respond /mcnanny/i, (msg) ->
    msg.send imgs["mcnanny"]
