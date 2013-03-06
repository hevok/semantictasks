###
  #SOCKET TEST
  It tests how websocket wrapper and channels work
###

chai = require 'chai'
chai.should()
expect = chai.expect;
require '../lib/batman.js'
require '../collab/socket_event.coffee'
require '../collab/channel.coffee'
require '../collab/mock_socket.coffee'
require '../collab/socket.coffee'


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

describe 'Socket', ->

  def.onmessage = (evt)->mdef = evt.content
  all.onmessage = (evt)->mall = evt.content
  bbc.onmessage = (evt)->mbbc = evt.content
  cnn.onmessage = (evt)->mcnn = evt.content
  ictv.onmessage = (evt)->mictv = evt.content


  it 'should broadcast info to the channels', ->

    event =
      data: "Hello default"
    event.data.channel = "default"

    #data = Batman.SocketEvent.fromEvent(event)

    fromString= (str)->
      if typeof str !="string" then throw new Error("not string received be fromString")
      data = Batman.SocketEvent.toJSON(data)
      if data is undefined or typeof(data)=="string" then return new Batman.SocketEvent(str,"default","save") else return data


    if event instanceof Batman.SocketEvent then console.log event
    if not event.hasOwnProperty("data") then throw new Error("No data inside of websocket event")
    data = event.data


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

  it "should work well with JSON", ->

    mock = socket.socket

    report =
      message:"BBC reports"
      user: "mock"


    event =
      data:
        content: JSON.stringify(report)
        channel: "bbc"
        request: "save"

    event.data = JSON.stringify(event.data)

    bbc = socket

    mbbc.should.equal = ""

    clean()



describe 'Mocksocket', ->
  it "should respond to save request",->
    mdef.should.equal ""
    mcnn.should.equal ""

    mock = socket.socket
    event =
      data:
        content: "BBC reports from mock"
        channel: "bbc"
        request: "save"


    mock.send event

    mbbc.should.equal "BBC reports from mock"

    event =
      content: "some default event"
      request: "save"

    mock.send event
    mdef.should.equal "some default event"
    mbbc.should.equal "BBC reports from mock"