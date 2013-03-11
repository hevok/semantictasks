###
# MockSocket class #
Mock socket is needed for tests to simulate websocket behaviour
###

#_require channel.coffee
#_require socket_event.coffee


class Batman.MockSocket extends Batman.Object
  ###
  #Mock socket#
  Mock socket is needed for tests to simulate websocket behaviour
  ###
  constructor: (@url)->
    @onreceive = Batman.MockSocket.mockCallback(@)


  onreceive: (event)->event


  send: (event)=>@onreceive(event)

  onopen: ->
    ###
    Open event
    ###
    console.log "open"

  onmessage: (event)->
    ###
    On message
    ###
    data = event.data;

  onclose: =>
    console.log "close"

  randomInt: (min, max)=>
    ###
      random int generating function
    ###
    Math.floor(Math.random() * (max - min + 1)) + min

  @mockCallback:  (mock)=>
    ###
      this callback is needed to store data inside mock sockets and respond to read requests and other queirs
      NAPILNIK
    ###
    (event)=>
      #console.log event
      data = Batman.SocketEvent.fromString(event)
      #console.log data
      switch data.request
        when "save"
          ###
            if we received request to save something we answer to it with result
          ###
          data.request = "answer"
          if data.content.id?
            ###
              if we were give id we just give item with appropriate id
            ###
            mock.set data.content.id, data
            all = mock.getOrSet(data.channel, =>new Batman.SimpleSet())
            all.add data.content
        when "delete"
          if data.content.id?
            id = data.content.id
            content = mock.get(data.channel)
            res = content.find (item)->item.id==id
            if res? then content.remove(res)
        when "read"
          if data.content.id?
            data = mock.get(data.content.id)
            data.request = "answer"
            mock.onmessage(data)
          else
            if data.content.query? and data.content.query=="all"
              col = mock.get(data.channel)
              if col? and col.length>0
                content = col.toArray()
                message = new Batman.SocketEvent(content, data.channel,"readAll")
                mock.onmessage(message)
              else
                mock.onmessage(new Batman.SocketEvent("_nil_", data.channel,"readAll"))

