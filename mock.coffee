###
   ##MockData
  this class creates some mock data to work with
###
class Chat.MockData extends Batman.Object
  constructor: ->
    @socket = Batman.Socket.getInstance()
    @massenger = @socket.socket

  showDaniel : 'Show this code to Daniel'
  integrate : 'Integrate with semantic chat application'
  runCode : 'Run this code in the browser'

  ###creates mock tasks
  ###
  createTasks: (num = 1)=>
    #JSON test
    json =
      owner: 'Robot'
      title: 'Tell them that I am alive'
      completed: false

    switch num
      when 1 then new Chat.Task(owner: "Anton", title: @showDaniel, completed: false).save()
      when 2 then new Chat.Task(owner: "Anton",title: @integrate, completed: false).save()
      when 3 then new Chat.Task(owner: "Daniel",title: @runCode, completed: false).save()
      #I used here JSON just to show another method to save data
      when 4 then Chat.Task.createFromJSON(json).save()
      else
        @createTasks(1)
        @createTasks(2)
        @createTasks(3)
        @createTasks(4)


  ###
    creates mock messages
  ###
  createMessages: (num = 1)=>
    json =
      text: 'I am still alive!'
      user: "Robot"
    switch num
      when 1
        @massenger.send
          data:
            content:
              text:"Hi, guys! Look at my code!"
              user:"Anton"
            request: "push"
            channel: Chat.Message.storageKey
      when 2
        new Chat.Message(text: "Wait a moment, I shall see", user: "Daniel").save()
        @completeTasksByTitle(@runCode)
        @completeTasksByTitle(@showDaniel)
      when 3 then new Chat.Message(text: "Comrades, it is not our primary focus, let's go and continue writing grant application!", user: "coced").save()
      when 4
        #I used here JSON just to show another method to save data
        Chat.Message.createFromJSON(json).save()
        @completeTasksByOwner("Robot")
      else
        @createMessages(1)
        @createMessages(2)
        @createMessages(3)
        @createMessages(4)


  #creates mock users
  createUsers: =>
    #checks if there are no users
    #if(not Chat.User.get('all').length)
    #creates mock users

    new Chat.User(name: "Anton", status:"active").save()
    new Chat.User(name: "Daniel", status:"active").save()
    new Chat.User(name: "coced", status:"active").save()
    new Chat.User(name: "Robot", status:"active").save()

  ###
  random int generating function
  ###
  randomInt: (min, max)=> Math.floor(Math.random() * (max - min + 1)) + min

  ###
    callback that generates mock data (one of two test objects each second)
  ###
  generate: =>
    num = @randomInt(1,4)
    switch @randomInt(1,2)
      when 1 then @createTasks(num)
      when 2 then @createMessages(num)
    setTimeout(@generate, 1500)

  ###
    Completes all tasks that has this owner
  ###
  completeTasksByOwner: (owner)=>
    all = Chat.Task.get("all").toArray()
    for item in all
      if item.get("owner") == owner and item.get("completed")==false
        #in Batman.js it is recommended to use set("propname",value) instead of object.prop = value
        #because set not only saves the value but also do a lot of other useful stuf (like views and binding updates)
        item.set "completed", true

  ###
    Completes all tasks that has this title
  ###
  completeTasksByTitle: (title)=>
    all = Chat.Task.get("all").toArray()
    for item in all
      if item.get("title") == title and item.get("completed")==false
        #in Batman.js it is recommended to use set("propname",value) instead of object.prop = value
        #because set not only saves the value but also do a lot of other useful stuf (like views and binding updates)
        item.set "completed", true

  ###
    Deletes items from localStorage of HTML
  ###
  kill : (items)=>
    arr = items.toArray()
    for item in arr
      item.destroy()

  #cleanup localstore
  cleanUp: =>
    @kill Chat.Message.get("all")
    @kill Chat.User.get("all")
    @kill Chat.Task.get("all")


mockData = new Chat.MockData()

mockData.cleanUp()
mockData.createTasks()
mockData.createMessages()
mockData.createUsers()
mockData.generate()


