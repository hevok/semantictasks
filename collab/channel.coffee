###
# Channel class #
Every sockets info to channels.
Channels are needed to communicate directly with the model
###

#_require socket_event.coffee

class Batman.Channel extends Batman.Object
  ###
  #Channel class
  Every sockets info to channels.
  Channels are needed to communicate directly with the model
  ###
  constructor: (@name) ->
    @on "onmessage", (event)=>@onmessage(event)

  save: (obj, id) =>
    obj.id = id
    @save obj

  save: (obj) =>
    data = Batman.SocketEvent.fromData(obj)
    data.channel = @name
    data.request = "save"
    @fire "send", data


  read: (id) =>@fire "send", new Batman.SocketEvent(id:id, @name, "read")

  readAll: => @fire "send", new Batman.SocketEvent(query:"all", @name, "read")

  remove: (id)=>@fire "send", new Batman.SocketEvent(id:id, @name, "delete")


  send: (obj) =>
    data = Batman.SocketEvent.fromData(obj)
    data.channel = @name
    @fire "send", data


  receive: (event) =>
    #should receive event with data
    @fire "onmessage",event

  onNextMessage:(fun)=>@once "onmessage", (event)=>fun(event)

  onmessage: (event) =>
    ###
      call back the receives info from socket send to this channel
    ###
    @fire "onmessage",event

  attach: (obj)=>
    ###
      Attaches the channel to the socket wrapper and subscribes to its events
    ###
    obj.on(@name, (event)=>@receive(event))
    obj.on("all", (event)=>@receive(event))
    @on "send", (data)=>obj.send(data)
    @
