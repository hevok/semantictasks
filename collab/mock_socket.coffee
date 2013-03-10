###
# MockSocket class #
Mock socket is needed for tests to simulate websocket behaviour
###

#_require channel.coffee
#_require socket_event.coffee


class Batman.MockSocket extends Batman.Object
  ###
  #Mock socket#
  Mock socket is needed for tests to simulate websocket behaviour
  ###
  constructor: (@url)->


  send: (event)=>@onreceive(event)

  onreceive: (event)=>


  onopen: ->
    ###
    Open event
    ###
    console.log "open"

  onmessage: (event)->
    ###
    On message
    ###
    data = event.data;

  onclose: =>
    console.log "close"

  randomInt: (min, max)=>
    ###
      random int generating function
    ###
    Math.floor(Math.random() * (max - min + 1)) + min