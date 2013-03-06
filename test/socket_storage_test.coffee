chai = require 'chai'
chai.should()
expect = chai.expect;
#require '../lib/jquery-1.9.1.js'
#require '../lib/batman.solo.js'
require '../lib/batman.js'
require '../collab/socket_event.coffee'
require '../collab/channel.coffee'
require '../collab/mock_socket.coffee'
require '../collab/socket.coffee'

describe 'In socket storage we', ->
  it 'run test', ->
    truth = "aging kills"
    truth.should.equal "aging kills"

    obj = new Batman.SocketEvent("1","2","push")
    check = obj instanceof Batman.SocketEvent
    console.log check

    check = obj instanceof String
    console.log check

    v =
      content: "content"
      channel: "channel"
      request: "request"


    #check = v instanceof String
    check = v instanceof Batman.SocketEvent
    console.log check

###
  it 'test write', ->

  it 'test read', ->

  it 'test readall', ->
###