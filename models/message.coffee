###
#model for messages#
contains text and user fields
###
class Chat.Message extends Batman.Model
  ###
  model for messages
  contains text and user fields
  ###

  @encode 'text', 'user'
  ###
    two fields to be stored: text and user
  ###


  @validate 'text', presence: true
  ###
    validate if text is present each time we create Message
  ###



  @persist Batman.SocketStorage
  ###
    messages are stored in browser local storage
  ###


  @storageKey: 'messages'
  ###
    key for local (by the browser) storage
  ###


