chai = require 'chai'
chai.should()
expect = chai.expect;
require '../lib/batman.js'
require '../collab/socket_event.coffee'
require '../collab/channel.coffee'
require '../collab/mock_socket.coffee'
require '../collab/socket.coffee'

describe 'Channels test:', ->

  socket = new Batman.Socket("none")

  def = socket.newChannel("default")
  all = socket.newChannel("all")
  bbc = socket.newChannel("bbc")
  cnn = socket.newChannel("cnn")
  ictv = socket.newChannel("ictv")

  mdef = ""
  mall = ""
  mbbc = ""
  mcnn = ""
  mictv =""

  clean = ->
    mdef=mall=mbbc=mcnn=mictv =""

  def.onmessage = (evt)->mdef = evt.content
  all.onmessage = (evt)->mall = evt.content
  bbc.onmessage = (evt)->mbbc = evt.content
  cnn.onmessage = (evt)->mcnn = evt.content
  ictv.onmessage = (evt)->mictv = evt.content


  it 'tests broadcasting', ->

    event =
      data: "Hello default"
    event.data.channel = "default"


    socket.broadcast(Batman.SocketEvent.fromEvent(event))

    mdef.should.equal "Hello default"
    mall.should.equal ""
    mcnn.should.equal ""

    socket.broadcast(new Batman.SocketEvent("Hello CNN", "cnn"))

    mdef.should.equal "Hello default"
    mall.should.equal ""
    mcnn.should.equal "Hello CNN"
    mbbc.should.equal ""

    clean()

  it 'tests mock socket', ->
    mdef.should.equal ""
    mcnn.should.equal ""

    mock = socket.socket
    event =
      data:
        content: "BBC reports from mock"
        channel: "bbc"


    #socket.on "default",-> console.log "def"
    #socket.on "bbc",-> console.log "bbc"

    mock.send event

    mbbc.should.equal "BBC reports from mock"

    event =
      data: "some default event"

    mock.send event
    mdef.should.equal "some default event"
    mbbc.should.equal "BBC reports from mock"
