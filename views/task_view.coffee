#a view for tasks of this chat
class Chat.TaskView extends Batman.View
  constructor: ->
    # process arguments and stuff
    super
    #write node to separate variable, node is an HTMLNode to which view is attached to
    node = @get("node")


