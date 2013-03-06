#_require ./socket_event.coffee
#_require ./channel.coffee
#_require ./socket.coffee
#_require ./mock_storage.coffee

class Batman.SocketStorage extends Batman.StorageAdapter
  constructor: ->
    #return null if typeof window.localStorage is 'undefined'
    super
    @socket = new Batman.Socket.getInstance()
    @storage = new Batman.MockStorage()

  ###
  subscribes a model to the channel
  ###
  subscribe: (model,storageKey)=>
    @channel = @socket.newChannel(storageKey)
    @channel.onmessage = (event)=>
      all = model.get("all")
      all.add(event.content)



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
    @subscribe(model, key)
    next()

  ###
    ##Generates GUI as id for a record
  ###
  nextIdForRecord : ->
    "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".replace /[xy]/g, (c) ->
      r = Math.random() * 16 | 0
      v = (if c is "x" then r else (r & 0x3 | 0x8))
      v.toString 16

  @::before 'read', 'create', 'update', 'destroy', @skipIfError (env, next) ->
    if env.action == 'create'
      env.id = env.subject.get('id') || env.subject._withoutDirtyTracking => env.subject.set('id', @nextIdForRecord())
    else
      env.id = env.subject.get('id')

    unless env.id?
      env.error = new @constructor.StorageError("Couldn't get/set record primary key on #{env.action}!")
    else
      #env.key = @storageKey(env.subject) + env.id
      env.key = env.id
    next()

  create: @skipIfError ({key, recordAttributes}, next) ->
    console.log key
    console.log recordAttributes
    if @storage.getItem(key)
      arguments[0].error = new @constructor.RecordExistsError
    else
      @storage.setItem(key, recordAttributes)
    next()

  update: @skipIfError ({key, recordAttributes}, next) ->
    @storage.setItem(key, recordAttributes)
    next()

  destroy: @skipIfError ({key}, next) ->
    @storage.removeItem(key)
    next()

  #################COPY PASTED CODE LIES UNDERNEATH########################


  _storageEntriesMatching: (constructor, options) ->
    re = @storageRegExpForRecord(constructor.prototype)
    records = []
    @_forAllStorageEntries (storageKey, storageString) ->
      if keyMatches = re.exec(storageKey)
        data = @_jsonToAttributes(storageString)
        data[constructor.primaryKey] = keyMatches[1]
        records.push data if @_dataMatches(options, data)
    records

  _dataMatches: (conditions, data) ->
    match = true
    for k, v of conditions
      if data[k] != v
        match = false
        break
    match


  @::before 'create', 'update', @skipIfError (env, next) ->
    env.recordAttributes = JSON.stringify(env.subject)
    next()

  @::after 'read', @skipIfError (env, next) ->
    if typeof env.recordAttributes is 'string'
      try
        env.recordAttributes = @_jsonToAttributes(env.recordAttributes)
      catch error
        env.error = error
        return next()
    env.subject._withoutDirtyTracking -> @fromJSON env.recordAttributes
    next()

  @::after 'read', 'create', 'update', 'destroy', @skipIfError (env, next) ->
    env.result = env.subject
    next()

  @::after 'readAll', @skipIfError (env, next) ->
    env.result = env.records = for recordAttributes in env.recordsAttributes
      @getRecordFromData(recordAttributes, env.subject)
    next()

  read: @skipIfError (env, next) ->
    env.recordAttributes = @storage.getItem(env.key)
    if !env.recordAttributes
      env.error = new @constructor.NotFoundError()
    next()
