#a view for messages of this chat
class Chat.MessageView extends Batman.View
  constructor: ->
    # process arguments and stuff
    super
    #writes node to separate variable, node is an HTMLNode to which view is attached to
    #@node = $ @get("node")
