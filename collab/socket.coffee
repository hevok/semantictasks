#_require socket_event.coffee
#_require channel.coffee

##websocket wrapper that broadcast info to its channels
#it not only uses either real or mock socket but broadcasts messages to various channels through events
class Batman.Socket extends Batman.Object
  #creates a socket object
  constructor: (@url)->
    #checks if websocket is in batman container
    @socket = if(Batman.container.hasOwnProperty("websocket"))
      Batman.container["websocket"]
    else
      @createInnerSocket(@url)
    @socket.onmessage = (event)=>@broadcast(Batman.SocketEvent.fromEvent(event))
    Batman.container.socket = @


  @getInstance: (url="none")=>
    if Batman.container.hasOwnProperty("socket") then Batman.container.socket else new Batman.Socket(url)

  createInnerSocket:  (url)=>
    @socket = unless url=="none"
      new WebSocket(@url)
    else
      new Batman.MockSocket(@url)
    Batman.container.websocket = @socket


  ###
  broadcasts the message further
  ###
  broadcast: (event)->
    unless event instanceof Batman.SocketEvent
      throw Error 'should be socket event'
    @fire(event.channel, event)

  newChannel: (name)=> new Batman.Channel(name).attach(@)

  send: (obj)->
    if typeof obj == 'string'
      json = data: obj
    else
      json = obj
    @socket.send(json)

  ###

  #duplication to be fixed in the Future
  send: (obj, channelName) ->

    if typeof obj == 'string'
      json = data: obj
    else
      json = obj
    json.channel = channelName
    @socket.send(json)
   ###