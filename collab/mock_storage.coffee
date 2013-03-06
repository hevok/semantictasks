#_require socket_event.coffee
#_require channel.coffee
#_require socket.coffee

#nothing here there, it is just a localStorage wrapper

class Batman.MockStorage
  constructor: ->
    #return null if typeof window.localStorage is 'undefined'
    @storage = localStorage


  getItem: (key)-> @storage.getItem key

  setItem: (key,value)-> @storage.setItem(key,value)

  removeItem: (key)-> @storage.removeItem(key)

  length: ->@storage.length
  #length: @storage.length

  key: (i)-> @storage.key(i)
