###
  #MOCKSOCKET TEST
  It tests how websocket wrapper and channels work
###

chai = require 'chai'
chai.should()
expect = chai.expect;
require './mock_channels.coffee'
require '../lib/batman.js'
require '../collab/socket_event.coffee'
require '../collab/channel.coffee'
require '../collab/mock_socket.coffee'
require '../collab/socket.coffee'


describe 'Mocksocket', ->
  it "should respond to save request",->

    channels = new Batman.MockChannels()
    mock = channels.getMock()

    mock.onreceive = (event)=>
      data = Batman.SocketEvent.fromData(event)
      if(data.request=="save")
        mock.onmessage(data)

    event =
      data:
        content: "BBC reports from mock"
        channel: "bbc"
        request: "save"


    mock.send event

    channels.bbc.last.should.equal "BBC reports from mock"

    event =
      content: "some default event"
      request: "save"

    mock.send event
    channels.def.last.should.equal "some default event"
    channels.bbc.last.should.equal "BBC reports from mock"