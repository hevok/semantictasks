###
# SocketEvent class #
Socket Event class is a class that does all conversions and packing of events send by sockets and channels
###

class Batman.SocketEvent
  ###
  Socket Event class is a class that does all conversions and packing of events send by sockets and channels
  ###

  constructor: (@content,@channel, @request = "push")->

  @fromEvent: (event)->
    ###
    factory that generate SocketEvent from websocket event
    ###
    if event instanceof Batman.SocketEvent then return event
    if not event.hasOwnProperty("data") then throw new Error("No data inside of websocket event")
    @fromData(event.data)


  @fromData: (data)->
    ###
    factory that generate SocketEvent from the data
    ###
    if data instanceof Batman.SocketEvent then return data
    if typeof(data) =="string" then return @fromString(data)
    #to avoid typical bug of nested data
    data = data.data if data.hasOwnProperty("data")
    channel = if(data.hasOwnProperty("channel")) then data.channel else "default"
    content = if(data.hasOwnProperty("content")) then @toJSON(data.content)  else data
    request = if(data.hasOwnProperty("request")) then data.request else "push"
    new Batman.SocketEvent(content,channel,request)


  @fromString: (str)->
    ###
    factory that generate SocketEvent from some string
    ###
    if typeof str !="string" then throw new Error("not string received be fromString")
    data = @toJSON(data)
    return  if data is undefined or typeof(data)=="string" then new Batman.SocketEvent(str,"default","save") else @fromData(data)


  @toJSON = (str) ->
    ###
    tries to convert string to json, returns initial string if failed
    ###
    if typeof str !="string" then return str
    try
      obj = JSON.parse str
    catch e
      return str
    if obj==undefined then str else obj

