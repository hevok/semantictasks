### Channel class
evey socket sends info for various channels
to channels the models will be binded
each model will have a channel that is connected to its storage key
###
class Batman.Channel extends Batman.Object
  constructor: (@name) ->

  send: (obj) =>
    fire "send", obj

  receive: (event) =>
    if event.hasOwnProperty("data")
      @onmessage(event.data)
    else
      @onmessage event

  onmessage: (event) =>

  attach: (obj)=>
    obj.on(@name, (event)=>@receive(event))
    obj.on("all", (event)=>@receive(event))
    @

##websocket wrapper that broadcast info to its channels
#it not only uses either real or mock socket but broadcasts messages to various channels through events
class Batman.Socket extends Batman.Object
  #creates a socket object
  constructor: (@url, real = yes)->
    #checks if websocket is in batman container
    if Batman.container.hasOwnProperty("socket")
      @socket = Batman.container["socket"]
    else
      if real
        @socket = new WebSocket(@url)
      else
        @socket = new Batman.MockSocket(@url)
      Batman.container.socket = @socket
      @socket.onmessage = (event)=>@broadcast(event)

  broadcastTo: (message, channelName) ->
    if typeof message == 'string'
      message =
        data: message
        channel: channelName
    else
      message.channel = channelName
    @broadcast(message)

  broadcast: (message)->
    if message.hasOwnProperty("channel")
      @fire(message.channel,message)
    else
      if message.hasOwnProperty("data") and message.data.hasOwnProperty("channel")
        @fire(message.data.channel, message.data)
      else
        @fire("default", message)

  newChannel: (name)=> new Batman.Channel(name).attach(@)

  send: (obj)->
    if typeof obj == 'string'
      json = data: obj
    else
      json = obj
    @socket.send(json)



  #duplication to be fixed in the Future
  send: (obj, channelName) ->

    if typeof obj == 'string'
      json = data: obj
    else
      json = obj
    json.channel = channelName
    @socket.send(json)
