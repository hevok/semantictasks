#disable routingkey warnings for controllers
Batman.config.minificationErrors = false

#Application object of the chat
class Chat extends Batman.App
  #@root '#'
  #@route "/completed", "tasks#completed"
  #@route "/active", "tasks#active"

#stores to global container
container = Batman.container
container.Chat = Chat

#add listener to the window object to fire run when everything has been loaded
if(window?)
  window.addEventListener 'load', ->
    Chat.run()
