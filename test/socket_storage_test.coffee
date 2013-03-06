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

###
  There will be tests for SocketStorage
###


describe 'In socket storage we', ->
  ###
  Just a sample test to test if all is working well
  ###
  it 'run test', ->
    truth = "aging kills"
    truth.should.equal "aging kills"
