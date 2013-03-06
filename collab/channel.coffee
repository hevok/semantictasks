#_require socket_event.coffee

###
  #Channel class
  Every sockets info to channels.
  Channels are needed to communicate directly with the model
###
class Batman.Channel extends Batman.Object
  constructor: (@name) ->

  send: (obj) =>
    fire "send", obj

  #should receive event with data
  receive: (event) => @onmessage(event)#@onmessage(event.content)

  ###
  call back the receives info from socket send to this channel
  ###
  onmessage: (event) =>

  ###
  Attaches the channel to the socket wrapper and subscribes to its events
  ###
  attach: (obj)=>
    obj.on(@name, (event)=>@receive(event))
    obj.on("all", (event)=>@receive(event))
    @
