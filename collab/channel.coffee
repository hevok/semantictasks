#_require socket_event.coffee

### Channel class
evey socket sends info for various channels
to channels the models will be binded
each model will have a channel that is connected to its storage key
###
class Batman.Channel extends Batman.Object
  constructor: (@name) ->

  send: (obj) =>
    fire "send", obj

  #should receive event with data
  receive: (event) => @onmessage(event)#@onmessage(event.content)

  onmessage: (event) =>

  attach: (obj)=>
    obj.on(@name, (event)=>@receive(event))
    obj.on("all", (event)=>@receive(event))
    @
