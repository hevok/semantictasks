chai = require 'chai'
chai.should()
expect = chai.expect;
require './mock_channels.coffee'
require '../lib/batman.js'
require '../collab/socket_event.coffee'
require '../collab/channel.coffee'
require '../collab/mock_socket.coffee'
require '../collab/socket.coffee'
require '../collab/socket_storage.coffee'


###
  There will be tests for SocketStorage
###
class Batman.MockModel extends Batman.Object
  ###
  Just a mock model class to test storage
  ###
  @storageKey: 'messages'

  @_doStorageOperation: (operation, options, callback) ->
    Batman.developer.assert @::hasStorage(), "Can't #{operation} model #{Batman.functionName(@constructor)} without any storage adapters!"
    adapter = @::_batman.get('storage')
    adapter.perform(operation, @, options, callback)

  _doStorageOperation: (operation, options, callback) ->
    Batman.developer.assert @hasStorage(), "Can't #{operation} model #{Batman.functionName(@constructor)} without any storage adapters!"
    adapter = @_batman.get('storage')
    adapter.perform operation, @, options, =>
      callback(arguments...)

  @persist: (mechanism, options...) ->
    Batman.initializeObject @prototype
    mechanism = if mechanism.isStorageAdapter then mechanism else new mechanism(@)
    Batman.mixin mechanism, options... if options.length > 0
    @::_batman.storage = mechanism
    mechanism


mockCallback =  (mock)=>
  (event)=>
    #console.log event
    data = Batman.SocketEvent.fromString(event)
    #console.log data
    switch data.request
      when "save"
        data.request = "answer"
        id = data.id
        mock.set id, data
      when "read"
        data = mock.get(data.id)
        data.request = "answer"
        mock.onmessage(data)


describe "In socket storage we use socket's channels to", ->

  channels = new Batman.MockChannels()
  mock = channels.getMock()
  mock.onreceive = mockCallback(mock)

  it 'run test', ->
    ###
    Just a sample test to test if all is working well
    ###
    truth = "aging kills"
    truth.should.equal("aging kills")

  it "answer questions", ->
    id1 = Batman.SocketEvent.genId()
    id2 = Batman.SocketEvent.genId()

    event1 =
      id:id1
      content : "somecontent1"

    event2 =
      id:id2
      content:"somecontent2"

    event1.request = "save"
    event2.request = "save"

    channels.ictv.send event1
    channels.ictv.send event2


    mock.get(id1).content.should.equal("somecontent1")
    mock.get(id2).content.should.equal("somecontent2")


    channels.ictv.onmessage = (event)=>
      event.content.should.equal "somecontent2"

    channels.ictv.ask id2

    channels.ictv.onmessage = (event)=>
      event.content.should.equal "somecontent1"

    channels.ictv.ask id1


    it "read records", ->
      storage = new Batman.SocketStorage()
      Batman.MockModel.persist(storage)







