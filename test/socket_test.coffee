chai = require 'chai'
chai.should()
expect = chai.expect;
require '../lib/batman.js'
require '../collab/mock_socket.coffee'
require '../collab/socket.coffee'


describe 'MockSocket test', ->

  it 'should test sending', ->
    mock = new Batman.MockSocket("testurl")
    message = "test content"
    mock.onmessage = (str)-> message = str
    message.should.not.equal "Hello"
    mock.send "Hello"
    message.should.to.have.ownProperty("data")
    message.data.should.equal "Hello"

describe 'Channels tests', ->

  socket = new Batman.Socket("someurl", no)

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

  def.onmessage = (str)->mdef = str
  all.onmessage = (str)->mall = str
  bbc.onmessage = (str)->mbbc = str
  cnn.onmessage = (str)->mcnn = str
  ictv.onmessage = (str)->mictv = str

  it 'should test broadcasting', ->

    event =
      data: "Hello default"
    event.data.channel = "default"


    socket.broadcast(event)

    mdef.should.equal "Hello default"
    mall.should.equal ""
    mcnn.should.equal ""

    socket.broadcastTo("Hello CNN", "cnn")

    mdef.should.equal "Hello default"
    mall.should.equal ""
    mcnn.should.equal "Hello CNN"
    mbbc.should.equal ""

    clean()

  it 'should test mock socket', ->
    mdef.should.equal ""
    mcnn.should.equal ""

    mock = socket.socket
    event =
      data: "BBC reports from mock"
    event.channel = "bbc"


    #socket.on "default",-> console.log "def"
    #socket.on "bbc",-> console.log "bbc"

    mock.send event


    mbbc.should.equal "BBC reports from mock"


