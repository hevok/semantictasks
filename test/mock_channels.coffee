###
  #Mock class for testing with socket channels#
###
require '../lib/batman.js'

class Batman.MockChannels
  ###
    ##Mock class for testing with socket channels##
  ###

  constructor: (@url="none")->
    @socket = new Batman.Socket(@url)
    @def = @socket.getChannel("default")
    @all = @socket.getChannel("all")
    @bbc = @socket.getChannel("bbc")
    @cnn = @socket.getChannel("cnn")
    @ictv = @socket.getChannel("ictv")
    @cleanLasts()
    @subscribeChannels()


  subscribeChannels: ->
    ###
      fill variables with last values
    ###
    @def.onmessage = (evt)=>@def.last = evt.content
    @all.onmessage = (evt)=>@all.last = evt.content
    @bbc.onmessage = (evt)=>@bbc.last = evt.content
    @cnn.onmessage = (evt)=>@cnn.last = evt.content
    @ictv.onmessage = (evt)=>@ictv.last = evt.content

  getMock: ->@socket.socket

  cleanLasts: ->
    @def.last = @all.last = @bbc.last = @cnn.last = @ictv.last = ""


