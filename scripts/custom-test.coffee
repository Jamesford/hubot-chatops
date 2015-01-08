# Description:
#   Test the chato.ps custom plugin feature
#
# Dependencies:
#   "underscore": "1.7.0"
#
# Configuration:
#   HUBOT_CHATOPS_CUSTOM_TEST
#
# Commands:
#   test bot hearing - Tests `robot.hear` method
#   hubot test response - Tests `robot.respond` method
#   hubot test http - Tests `robot.http()` method
#   hubot test envar - Tests environment variable was set
#   hubot test dependencies - Tests dependencies are available
#
# URLS:
#   POST /hubot/test/chatops/whpost/:user
#
# Author:
#   Jamesford
#

envar = process.env.HUBOT_CHATOPS_CUSTOM_TEST
_ = require 'underscore'

module.exports = (robot) ->
    robot.hear /test bot hearing/i, (msg) ->
        msg.send 'I heard "test bot hearing" being said'

    robot.respond /test response/i, (msg) ->
        msg.send 'Responding to "testresponse"!'

    robot.respond /test http/i, (msg) ->
        robot.http('http://www.randomtext.me/#/gibberish/p-1/5-10')
            .get() (err, res, body) ->
                if err
                    msg.send 'Encountered error:', err
                else
                    msg.send "#{body}"

    robot.enter (msg) ->
        msg.send 'Hello!'

    robot.leave (msg) ->
        msg.send 'Aww they left!'

    robot.respond /test envar/i, (msg) ->
        unless answer?
            msg.send "Missing HUBOT_CHATOPS_CUSTOM_TEST in environment: please set and try again"
            return
        msg.send "HUBOT_CHATOPS_CUSTOM_TEST: #{envar}"

    robot.respond /test dependencies/i, (msg) ->
        range = _.range(10)
        msg.send "_.range(10): #{range}"

    robot.router.post '/hubot/test/chatops/whpost/:user', (req, res) ->
        user = req.params.user
        data = JSON.parse req.body.payload
        robot.send user, "Received post data: #{data}"