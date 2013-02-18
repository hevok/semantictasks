#this class creates some mock data to work with
class Chat.MockData extends Batman.Object

#creates mock tasks
  createTasks: ->
    #checks if there are no tasks
    if(not Chat.Task.get('all').length)
      #add tasks if the tasklist is empty
      new Chat.Task(title: 'Show this code to Daniel', completed: true).save()
      new Chat.Task(title: 'Integrate with semantic chat application', completed: false).save()
      new Chat.Task(title: 'Run this code in the browser', completed: true).save()

  #creates mock messages
  createMessages: ->
    #checks if there are no messages
    if(not Chat.Message.get('all').length)
      new Chat.Message(text: "Hi guys! Look at my code!", user: "Anton").save()
      new Chat.Message(text: "Wait a moment, I shall see", user: "Daniel").save()
      new Chat.Message(text: "Comrades, it is not our primary focus, let's go and continue writing grant application!", user: "coced").save()

  #creates mock users
  createUsers: =>
    #checks if there are no users
    if(not Chat.User.get('all').length)
      #creates mock users
      new Chat.User(name: "Anton", status:"active").save()
      new Chat.User(name: "Daniel", status:"active").save()
      new Chat.User(name: "coced", status:"active").save()

mockData = new MockData
mockData.createTasks()
mockData.createMessages()
mockData.createUsers()
