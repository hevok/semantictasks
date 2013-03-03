class Batman.MockSocket extends Batman.Object
  constructor: (@url)->

  send: (str)->
    if typeof str is String
      @onmessage(data :str)
    else
      if(str.hasOwnProperty("data"))
        @onmessage str
      else
        @onmessage data: JSON.stringify(str)


  onopen: ->
    console.log "open"

  onmessage: (event)->
    data = event.data;
    console.log "onmessage: "+data

  onclose: ->
    console.log "close"


  #random int generating function
  randomInt: (min, max)=> Math.floor(Math.random() * (max - min + 1)) + min


class Batman.Channel extends Batman.Object
  constructor: (@name) ->

  send: (obj) ->
    fire "send", obj
  onmessage: (event) ->
    console.log "!"

  attach: (obj)->
    obj.on(@name,@onmessage)



#websocket wrapper that broadcast info to its channels
class Batman.Socket extends Batman.Object
  #creates a socket object
  constructor: (@url, mock = no)->
    #checks if websocket is in batman container
    if Batman.contains("socket")
      @socket = Batman.container.get("socket")
    else
      if not mock
        @socket = new WebSocket(@url)
      else
        @socket = new MockSocket(@url)
      Batman.container.set "socket", @socket
      socket.onmessage = broadcast

  broadcast: (event)->
    if event.hasOwnProperty("data")
      message event.data
    else
      message = event
    if message.hasOwnProperty("channel")
      @fire(message.channel,message)
    else
      @fire("default",message)

  send: (obj, channelName) ->

    if typeof obj is String
      json = data: obj
    else
      json = obj
    json.channel = channelName

    @socket.send(json)


