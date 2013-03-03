class Chat.SocketStorage extends Batman.LocalStorage
  constructor: ->
    #return null if typeof window.localStorage is 'undefined'
    super
    @storage = new Chat.MockStorage()

  #just a test of subscribtions that will be used for push notification in the future
  @subscribe: (model,storageKey)=>
    randomInt = (min, max)=> Math.floor(Math.random() * (max - min + 1)) + min
    json =
      text: "IT WORKS!"
      user: "robot"
    addModel = ->
      json.id = json.id+ randomInt(0,1000)
      record = model.createFromJSON(json) #.save()
      model.get("all").add(record)
    @on storageKey, addModel
    fun = ->
      Chat.SocketStorage.fire storageKey
      setTimeout(fun,3000)
    setTimeout(fun,3000)



  #override to make things working with new storage

  _forAllStorageEntries: (iterator) ->
    for i in [0...@storage.length()]
      key = @storage.key(i)
      iterator.call(@, key, @storage.getItem(key))
    true

  #overrided readAll to add subscription

  readAll: @skipIfError (env, next) ->
    try
      arguments[0].recordsAttributes = @_storageEntriesMatching(env.subject, env.options.data)
    catch error
      arguments[0].error = error
    model = env.subject
    key = model.storageKey
    SocketStorage.subscribe(model, key)
    next()
