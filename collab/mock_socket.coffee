#_require channel.coffee
#_require socket_event.coffee


class Batman.MockSocket extends Batman.Object
  constructor: (@url)->

  send: (event)=>
    if typeof event == 'string'
      @onmessage(data :event)
    else
      if(event.hasOwnProperty("data"))
        @onmessage event
      else
        @onmessage data: JSON.stringify(event)

      #event = Batman.SocketEvent.fromEvent()


  onopen: =>
    console.log "open"

  onmessage: (event)=>
    data = event.data;
    console.log "onmessage: "+data

  onclose: =>
    console.log "close"


  #random int generating function
  randomInt: (min, max)=> Math.floor(Math.random() * (max - min + 1)) + min