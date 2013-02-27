#model for users of the chat, now is only used for test purposes
class Chat.User extends Batman.Model

  #declares that properties name and status will be saved when @save() is called
  @encode 'name', 'status'

  #validate if title is present each time we create User
  @validate 'name', presence: true

  #tells that all data saved by @save() function will be stored in the Browser local storage
  @persist Batman.LocalStorage

  #key for local (by the browser) storage
  @storageKey: 'users'



