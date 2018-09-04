# Description:
#   Useful hubot script for Cornell
#   
# Dependencies:
#   "cheerio": "0.7.0"
#
# Configuration:
#   HUBOT_PLACE_API_KEY - Obtained from https://console.developers.google.com
#
# Commands:
#   yamabot kft hours - Kung Fu Tea hours
#   yamabot oth hours - Old Teahouse hours
#   yamabot chipotle hours - Chipotle hours
#   yamabot is <restaurant name> open - check if restaurant is open
#   yamabot is cornell open - checks university operating status
#   yamabot when are <class code> exams - retrieves exam dates

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
    
  # Is restaurant open?
  robot.respond /is (.*) open?/i, (msg) ->
    unless process.env.HUBOT_PLACE_API_KEY
      return msg.send "You must configure the HUBOT_PLACE_API_KEY environment variable."
    query = msg.match[1]
    robot.http("https://maps.googleapis.com/maps/api/place/nearbysearch/json")
      .query({
        key: process.env.HUBOT_PLACE_API_KEY
        keyword: query
        location: "42.453459,-76.473532"
        radius: 5000
        types: "restaurant|grocery_or_supermarket|meal_delivery|meal_takeaway|bakery|cafe|convenience_store"
      })
      .get() (err, res, body) ->
        json = JSON.parse(body)
        results = json.results
        #msg.send result.name for result in results
        
        unless results? && results.length > 0
          return msg.send "I couldn\'t find that restaurant nearby..."
        
        if results[0].opening_hours.open_now
          msg.send "#{results[0].name} is open!"
        else
          msg.send "Sorry, #{results[0].name} is closed."
    
  # Operating status =================
  robot.respond /is cornell open/i, (msg) ->
    msg.http("http://www.cornell.edu/status/").get() (err, res, body) ->
      $ = cheerio.load(body)
      if res.statusCode != 200
        msg.send "I can't connect to the Cornell website right now."
      else
        msg.send $('h2.pagetitle').text()
  
  # Exams ============================
  fetchExamDate = (msg, url, class_code) ->
    msg.http(url).get() (err, res, body) ->
      if res.statusCode != 200
        msg.send "I can't connect to the Cornell website right now."
      else
        $ = cheerio.load(body)
        schedule = $('pre').text()
        lines = schedule.split('\n')
        result = line for line in lines when line.indexOf(class_code) != -1
        if result
          msg.send result
        else
          msg.send "That class isn't on this semester's schedule."
  
  robot.respond /when are ([A-Z]{2,5}\s[0-9]{4}) exams/i, (msg) ->
    current_date = new Date()
    month = current_date.getMonth()+1
    class_code = msg.match[1].toUpperCase()
    if month >=6
      fetchExamDate(msg, "https://registrar.cornell.edu/exams/fall-prelim-exam-schedule", class_code)
    else
      fetchExamDate(msg, "https://registrar.cornell.edu/exams/fall-prelim-exam-schedule", class_code)
  
  # Live Image =======================
  robot.respond /cornell now/i, (msg) ->
    msg.send "http://cs1.pixelcaster.com/cornell/cornell.jpg"



  
