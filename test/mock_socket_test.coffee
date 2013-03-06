chai = require 'chai'
chai.should()
expect = chai.expect;
require '../lib/batman.js'
require '../collab/socket_event.coffee'
require '../collab/channel.coffee'
require '../collab/mock_socket.coffee'
require '../collab/socket.coffee'


describe 'MockSocket', ->

  genId = ->
  "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".replace /[xy]/g, (c) ->
    r = Math.random() * 16 | 0
    v = (if c is "x" then r else (r & 0x3 | 0x8))
    v.toString 16
  ###
  it 'should send info well', ->
    mock = new Batman.MockSocket("none")
    message = "test content"
    mock.onmessage = (str)-> message = str
    message.should.not.equal "Hello"
    mock.send "Hello"
    message.should.to.have.ownProperty("data")
    message.data.should.equal "Hello"

  it 'should respond to save requests by pushing', ->
    socket = Batman.Socket.getInstance()
    mock = socket.socket

    message = "test content"
    mock.onmessage = (str)-> message = str

    guid = genId()
    channel = "bbc"

    data =
      content: "some content"
      request: "save"
      id: guid
      channel: "bbc"

    message.should.not.equal "Hello"

    mock.send "Hello"

    message.should.to.have.ownProperty("data")
    message.data.should.equal "Hello"

    socket.send event

    message.should.to.have.ownProperty("data")
###