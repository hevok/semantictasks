###
This event is needed for convenient packing of the event info
###
class Batman.SocketEvent
  constructor: (@content,@channel, @request = "push")->

  #factory that generate SocketEvent from websocket event
  @fromEvent: (event)->
    if event instanceof Batman.SocketEvent then return event
    if not event.hasOwnProperty("data") then throw new Error("No data inside of websocket event")
    @fromData(event.data)


  #factory that generate SocketEvent from some data
  @fromData: (data)->
    if data instanceof Batman.SocketEvent then return data
    channel = if(data.hasOwnProperty("channel")) then data.channel else "default"
    content = if(data.hasOwnProperty("content")) then data.content  else data
    request = if(data.hasOwnProperty("request")) then data.request else "push"
    new Batman.SocketEvent(content,channel,request)

