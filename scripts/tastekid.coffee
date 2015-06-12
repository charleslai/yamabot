# Description:
#   Suggest media based on TasteKid
#   
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_TASTEKID_API_KEY - Obtained from http://www.tastekid.com/account/api_access
#
# Commands:
#   yamabot similar <query> - Returns similar artists/books/games/authors

module.exports = (robot) ->

  robot.respond /similar (.*)/i, (msg) ->
    unless process.env.HUBOT_TASTEKID_API_KEY
      return msg.send "You must configure the HUBOT_TASTEKID_API_KEY environment variable."
    query = msg.match[1]
    robot.http("http://www.tastekid.com/api/similar")
      .query({
        q: query
        limit: 5
        info: 1
        k: process.env.HUBOT_TASTEKID_API_KEY
      })
      .get() (err, res, body) ->
        if res.statusCode != 200
          msg.send "Sorry, I couldn't connect to the TasteKid service."
        else
          json = JSON.parse(body)
          results = json.Similar.Results
        
        unless results? && results.length > 0
          return msg.send "I couldn\'t find any suggestions for you..."
        
        msg.send "If you like #{json.Similar.Info[0].Name}, then check out:"
        output = ""
        for result in results
          output += "#{result.Name} (#{result.Type})"
          if result.yUrl
            output += " #{result.yUrl}\n"
          else
            output += "\n"
        msg.send output