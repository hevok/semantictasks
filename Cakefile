#CAKE FILE
#----------
#this files makes all coffescript building process
#in order to run it you should have coffeescript and cake installed
#it can be done by by npm package manager
#npm install -g coffee-script
#npm install -g cake

#a task to explain what this cakefile does, kind of hello world=)
task 'explain', 'Explains what this cakefile does', ->
  console.log 'Ths cake compiles all models to models.js, the same for views and contollers'


#child process variable
{exec} = require 'child_process'

execute = (str)->
  exec str, (err, stdout, stderr) ->
    #throws errors if there are any
    throw err if err
    #prints log
    console.log stdout + stderr

#VARIABLES
#----------
#path where to take files from
path = "./"

coffees = "*.coffee"


###BUILDER

  helpful class for our biuild process
  can compile and generate docs for itself
###

class Builder

  @all: []

  #assigns basic params

  constructor: (@path, input, output)->
    @input = @path+input
    @output = @path+output
    Builder.all.push(@)

  compileStr:-> "coffee --compile --output #{@output} #{@input}"

  #compiles and joins models in single js file
  compile: -> execute @compileStr()

class FolderBuilder extends Builder
  constructor: (@path, input, output, fileName="")->
    super(@path, input,output)
    if fileName!="" then @fileName = @output+fileName else @fileName = ""
   # FolderBuilder.all.push(@)

  join: -> if @fileName != "" then  "--join #{@fileName}" else ""

  compileStr:-> "coffee #{@join()} --compile --output #{@output} #{@input}"

  #BUGGY!
  makeDoco: -> execute("docco #{@input}/#{coffees}")


appBuilder = new Builder(path,"chat.coffee","js/")
collabBuilder = new FolderBuilder(path, "collab", "js/","collab.js")
modelsBuilder = new FolderBuilder(path, "models", "js/", "models.js")
viewsBuilder = new FolderBuilder(path, "views", "js/","views.js")
controllersBuilder = new FolderBuilder(path, "controllers", "js/", "controllers.js")
mockBuilder = new Builder(path,"mock.coffee","js/")

#FUNCTIONS THAT ARE USED IN TASKS
#---------
#testing is described here http://net.tutsplus.com/tutorials/javascript-ajax/better-coffeescript-testing-with-mocha/
test = ->
  console.log "Testing started"
  execute("mocha --compilers coffee:coffee-script")
  console.log "Testing completed"


compile = ->
  console.log "Compilation started"
  for builder in Builder.all
    builder.compile()
  console.log "Compilation completed"

#generates docs for sources
#for this command docco ( https://github.com/jashkenas/docco ) should be installed
#
#pygments should also be installed
#in Linux it can be installed by
# sudo easy_install pygments
makeDocos = ->
  console.log "Documentation generation started"
  execute("docco #{path}#{coffees}")
  for builder in FolderBuilder.all
    if typeof builder is FolderBuilder then builder.makeDoco()
  console.log "Documentation generation completed"

#makeCoffeeDocs= ->



#CAKE TASKS TO BE EXECUTED WHEN CALLED cake <taskname>
#-----


#makes compilation
task 'compile', 'Compiles coffeescript files in the project and moves them to output dir', ->
  compile()

#makes compilation
task 'test', 'Test coffescripts', ->
  test()


#makes docs
task 'make:docs', 'generates docs for sources', ->
  makeDocos()
  #makeCoffeeDoc()

#makes cleanup,compile and documenting
task 'build', 'Builds project from src/*.coffee to lib/*.js', ->
  console.log "Build task started"
  compile()
  makeDocos()
  test()

  #makeDocos()
  console.log "Build task completed"


