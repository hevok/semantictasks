#controller that works with all tasks
class Chat.TasksController extends Batman.Controller
  test: "test"

  constructor: ->
    super
    @set 'newTask', new Chat.Task(completed: false)

  items:->
    Task.get('all')

  #get all of the tasks
  all: ->
    @set 'currentTasks', Chat.Task.get('all')

  #completed tasks
  completed: ->
    @set 'currentTasks', Chat.Task.get('completed')
    @render source: 'tasks/all'

  #active tasks
  active: ->
    @set 'currentTasks', Chat.Task.get('active')
    @render source: 'tasks/all'

  #creates new task
  createTask: ->
    @get('newTask').save (err, task) =>
      if err
        throw err unless err instanceof Batman.ErrorsSet
      else
        @set 'newTask', Chat.Task(completed: false, title: "")

  taskDoneChanged: (node, event, context) ->
    task = context.get('task')
    task.save (err) ->
      throw err if err && !err instanceof Batman.ErrorsSet

  destroyTask: (node, event, context) ->
    task = context.get('task')
    task.destroy (err) -> throw err if err

  toggleAll: (node, context) ->
    Chat.Task.get('all').forEach (task) ->
      task.set('completed', !!node.checked)
      task.save (err) ->
        throw err if err && !err instanceof Batman.ErrorsSet

  clearCompleted: ->
    Chat.Task.get('completed').forEach (task) ->
      task.destroy (err) -> throw err if err

  toggleEditing: (node, event, context) ->
    task = context.get('task')
    editing = task.set('editing', !task.get('editing'))
    if editing
      input = document.getElementById("task-input-#{task.get('id')}")
      input.focus()
      input.select()
    else
      if task.get('title')?.length > 0
        task.save (err, task) ->
          throw err if err && !err instanceof Batman.ErrorsSet
      else
        task.destroy (err, task) ->
          throw err if err

  disableEditingUponSubmit: (node, event, context) ->
    if Batman.DOM.events.isEnter(event)
      @toggleEditing(node, event, context)