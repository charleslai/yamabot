# Description
#   Retrieves exam dates for Cornell classes.
#
# Dependencies:
#  "cheerio": "0.7.0"
#
# Configuration:
#   None
#
# Commands:
#   yamabot when are <class code> exams - retrieves exam dates for a class
#     e.g. "yamabot when are AEM 1200 exams"
#     From Jan-Jun, uses Spring schedule, Fall for other months
#
# Author:
#   nyanya

cheerio = require("cheerio")

module.exports = (robot) ->
  
  fetchExamDate = (msg, url, class_code) ->
    msg.http(url).get() (err, res, body) ->
      if res.statusCode != 200
        msg.send "I can't connect to the Cornell website right now."
      else
        $ = cheerio.load(body)
        schedule = $('pre').text()
        lines = schedule.split('\n')
        msg.send line for line in lines when line.indexOf(class_code) != -1
  
  robot.respond /when are ([A-Z]{2,5}\s[0-9]{4}) exams/i, (msg) ->
    class_code = msg.match[1].toUpperCase()
    current_date = new Date()
    month = current_date.getMonth()+1
    if month >=7
      fetchExamDate(msg, "https://registrar.cornell.edu/Sched/PRELF.html", class_code)
    else
      fetchExamDate(msg, "https://registrar.cornell.edu/Sched/PRELS.html", class_code)