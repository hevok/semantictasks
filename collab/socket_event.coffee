###
# SocketEvent class #
Socket Event class is a class that does all conversions and packing of events send by sockets and channels
###

class Batman.SocketEvent
  ###
  Socket Event class is a class that does all conversions and packing of events send by sockets and channels
  ###

  constructor: (@content, @channel, @request = "push")->
    unless @content.id? or @content.query then @content.id = SocketEvent.genId()
    #@id = if id=="" then SocketEvent.genId() else id

  @fromEvent: (event)->
    ###
    factory that generate SocketEvent from websocket event
    ###
    if event instanceof Batman.SocketEvent then return event
    if not event.data? then throw new Error("No data inside of websocket event")
    @fromData(event.data)

  @genId : ->
    ###
    ##Generates GUI as id for a record
    ###
    "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".replace /[xy]/g, (c) ->
      r = Math.random() * 16 | 0
      v = (if c is "x" then r else (r & 0x3 | 0x8))
      v.toString 16


  @fromData: (data)->
    ###
    factory that generate SocketEvent from the data
    ###
    if data instanceof Batman.SocketEvent then return data
    if typeof(data) =="string" then return @fromString(data)
    #to avoid typical bug of nested data
    data = data.data if data.data?
    channel = if data.channel? then data.channel else "default"
    content = data.content
    content = if data.content?
      if typeof data.content =="string" then @toJSON(data.content) else data.content
    else data
    request = if data.request? then data.request else "push"
    new Batman.SocketEvent(content,channel,request)


  @fromString: (str)->
    ###
    factory that generate SocketEvent from some string
    ###
    if typeof str !="string"
      throw new Error("not string received by fromString but "+JSON.stringify(str))
    data = @toJSON(str)
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

