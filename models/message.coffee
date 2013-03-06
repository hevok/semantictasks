###
#model for messages
contains text and user fields
###
class Chat.Message extends Batman.Model

  #two fields to be stored: text and user
  @encode 'text', 'user'

  #validate if text is present each time we create Message
  @validate 'text', presence: true


  #messages are stored in browser local storage
  #@persist Batman.LocalStorage
  @persist Batman.SocketStorage


  #key for local (by the browser) storage
  @storageKey: 'messages'

