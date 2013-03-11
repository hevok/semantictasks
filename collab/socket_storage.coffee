###
#SocketStorage#

This is a Socket storage adaptor needed to connect Batman's models to websocket
It has not been finished yet.
###


#_require ./socket_event.coffee
#_require ./channel.coffee
#_require ./socket.coffee
#_require ./mock_storage.coffee

class Batman.SocketStorage extends Batman.StorageAdapter
  ###
  #SocketStorage#

  This is a Socket storage adaptor needed to connect Batman's models to websocket
  It has not been finished yet.
  ###

  constructor: ->
    super
    @socket = new Batman.Socket.getInstance()
    @storage = new Batman.MockStorage()


  readAll: @skipIfError (env, next) ->
    ###
    overrided readAll to add subscription
    ###
    model = env.subject
    channel = @socket.getChannel(model.storageKey)
    channel.onmessage = (event)=>
      all = model.get("all")
      #id = event.content.id
      switch event.request
        when "push"
          #res = all.find (item)=>item.id==event.content.id
          #if res? then all.remove res
          all.add(event.content)
        when "delete"
          res = all.find (item)=>item.id==event.content.id
          if res? then all.remove res
    env.channel = channel
    try
      arguments[0].recordsAttributes = @_storageEntriesMatching(env.subject, env.options.data)
    catch error
      arguments[0].error = error
    next()


  _forAllStorageEntries: (array,iterator) ->
    ###
    override to make things working with new storage
    ###
    for i in [0...@storage.length()] ##########################################3insert array
      key = @storage.key(i)
      iterator.call(@, key, @storage.getItem(key))
    true

  _storageEntriesMatching: (constructor, options) ->
    re = @storageRegExpForRecord(constructor.prototype)
    records = []
    @_forAllStorageEntries (storageKey, storageString) ->
      if keyMatches = re.exec(storageKey)
        data = @_jsonToAttributes(storageString)
        data[constructor.primaryKey] = keyMatches[1]
        records.push data if @_dataMatches(options, data)
    records


  @::before 'read', 'create', 'update', 'destroy', @skipIfError (env, next) ->
    if env.action == 'create'
      env.id = env.subject.get('id') || env.subject._withoutDirtyTracking => env.subject.set('id', Batman.SocketEvent.genId())
    else
      env.id = env.subject.get('id')

    unless env.id? then env.error = new @constructor.StorageError("Couldn't get/set record primary key on #{env.action}!")
    env.key = env.subject.storageKey

    next()

  create: ({key,id, recordAttributes}, next) -> #@skipIfError ({channel,id, recordAttributes}, next) ->
    #alert "!!!!!!!!!!!!!!"
    console.log recordAttributes
    #recordAttributes.id = id
    console.log key
    channel = channel = @socket.getChannel(key)

    #channel.save(recordAttributes)
    #console.log recordAttributes
    #@storage.setItem(key, recordAttributes)
    next()

  update: @skipIfError ({id, recordAttributes}, next) ->
    #@storage.setItem(id, recordAttributes)
    next()

  destroy: @skipIfError ({channel,id}, next) ->
    channel.remove(id)
    #@storage.removeItem(id)
    next()

  #################COPY PASTED CODE LIES UNDERNEATH########################

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
    console.log env.result
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
