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

  send: (obj) =>
    fire "send", obj


  receive: (event) =>
    #should receive event with data
    @onmessage(event)#@onmessage(event.content)


  onmessage: (event) =>
    ###
      call back the receives info from socket send to this channel
    ###

  attach: (obj)=>
    ###
      Attaches the channel to the socket wrapper and subscribes to its events
    ###
    obj.on(@name, (event)=>@receive(event))
    obj.on("all", (event)=>@receive(event))
    @
