#disable routingkey warnings for controllers
Batman.config.minificationErrors = false

#Application object of the chat
class Chat extends Batman.App
  #@root '#'
  #@route "/completed", "tasks#completed"
  #@route "/active", "tasks#active"

#stores to global container
Batman.container.Chat = Chat


#add listener to the window object to fire run when everything has been loaded
window.addEventListener 'load', ->
  Chat.run()
