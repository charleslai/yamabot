# Description:
#   Useful hubot script for Yamatai
#   
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_YOUTUBE_API_KEY - Obtained from https://console.developers.google.com
#
# Commands:
#   yamabot mcnanny - Recieve a mcnanny

imgs = {
  mcnanny: "imgur link here"
}

tips = [
  "Don\'t curve your back or cave your torso during Yatai.",
  "Make sure your knees track over your toes when playing Miyake.",
  "Don\'t rush when playing fast notes!",
  "Power comes from your back, not from your arms.",
  "Change grips depending on what drum you\'re playing and the dynamics you want.",
  "Your knees should never go past your foot when playing Miyake.",
  "Always respect your alumni.",
  "Leave your problems behind when you come to practice.",
  "Practice often with a metronome.",
  "Use the right bachi for the drum, or you\'ll pull an Abhi and break the head.",
  "In the wise words of Dan Porter, DO IT LIKE THE CONCERT.",
  "Leo says: Don\'t do it bad. Do it good.",
  "Haruki recommends doing more pushups. And more anchorman.",
  "\"Keystone Light is the only beer for me\" - Miki",
  "Going topless is officially banned by the Yamatai constitution.",
  "The answer is always curry.",
  "Don\'t wait until the week before the concert to do transitions.",
  "Make sure your hips are square when you\'re in stance.",
  "Use your whole body when you play.",
  "When traveling to New York, stay at Hotel Taigen."
]

module.exports = (robot) ->
  
  # Specific Images
  robot.respond /mcnanny/i, (msg) ->
    msg.send imgs["mcnanny"]
    
  # Tips
  robot.respond /drop some knowledge/i, (msg) ->
    msg.send msg.random tips