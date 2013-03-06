###
# MockStorage class #
nothing here there, it is just a temporal localStorage wrapper
that will be deleted when I move everything to socketstorage
###

#_require socket_event.coffee
#_require channel.coffee
#_require socket.coffee

class Batman.MockStorage
  ###
    nothing here there, it is just a temporal localStorage wrapper
    that will be deleted when I move everything to socketstorage
  ###
  constructor: ->
    #return null if typeof window.localStorage is 'undefined'
    @storage = localStorage


  getItem: (key)-> @storage.getItem key

  setItem: (key,value)-> @storage.setItem(key,value)

  removeItem: (key)-> @storage.removeItem(key)

  length: ->@storage.length
  #length: @storage.length

  key: (i)-> @storage.key(i)