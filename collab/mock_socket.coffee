#_require channel.coffee
#_require socket_event.coffee

###
  ##Mock socket
  Mock socket is needed for tests to simulate websocket behaviour
###
class Batman.MockSocket extends Batman.Object
  constructor: (@url)->

  ###
    Send event to websocket
    if event's request is save, immediately make a mock response
  ###
  send: (event)=>
    data = Batman.SocketEvent.fromData(event)
    if(data.request =="save" or data.request =="create")
      data.request = "push"
    event =
      data: data
    @onmessage(event)



  ###
    Open event
  ###
  onopen: =>
    console.log "open"

  ###
    On message
  ###
  onmessage: (event)=>
    data = event.data;

  onclose: =>
    console.log "close"


  ###
    random int generating function
  ###
  randomInt: (min, max)=> Math.floor(Math.random() * (max - min + 1)) + min