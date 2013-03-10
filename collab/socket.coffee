###
  #Socket class#
  it not only uses either real or mock socket but broadcasts messages to various channels through events
###

#_require socket_event.coffee
#_require channel.coffee


class Batman.Socket extends Batman.Object
  ###
    websocket wrapper that broadcast info to its channels
    it not only uses either real or mock socket but broadcasts messages to various channels through events
  ###
  constructor: (@url)->
    ###
    creates a socket object
    ###
    #checks if websocket is in batman container
    @socket = if(Batman.container.hasOwnProperty("websocket"))
      Batman.container["websocket"]
    else
      @createInnerSocket(@url)
    @socket.onmessage = (event)=>@broadcast(Batman.SocketEvent.fromEvent(event))
    Batman.container.socket = @

  @getInstance: (url="none")=>
    ###
      works as singletone
    ###
    if Batman.container.socket? then Batman.container.socket else new Batman.Socket(url)

  createInnerSocket:  (url)=>
    @socket = unless url=="none"
      new WebSocket(@url)
    else
      new Batman.MockSocket(@url)
    Batman.container.websocket = @socket




  broadcast: (event)->
    ###
    broadcasts the message further
    ###
    unless event instanceof Batman.SocketEvent
      throw Error 'should be socket event'
    @fire(event.channel, event)

  getChannel: (name)=>  @getOrSet(name,=>new Batman.Channel(name).attach(@))

  send: (obj)->
    ###
    sends info to the websocket
    ###
    @socket.send(if typeof obj == 'string' then obj else JSON.stringify(Batman.SocketEvent.fromData(obj)))
    #@socket.send(if typeof obj == 'string' then Batman.SocketEvent.FromString(obj) else Batman.SocketEvent.fromData(obj))

