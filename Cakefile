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

#VARIABLES
#----------
#path where to take files from
path = "./"

#output path where to store compiled js files
out = path+"js/"

#app main file name
app = "chat.coffee"

#mock data file name
mock = "mock.coffee"

#path to our collaboration classes
collab = path+"collab"
#js file name to which the collab classes will be compiled
collabFile = out+"collab.js"


#path to models
models = path+"models"
#js file name to which the models will be compiled
modelsFile = out+"models.js"

#path to views
views = path+"views"

#js file name to which the views will be compiled
viewsFile = out+"views.js"

#path to controllers
controllers = path+"controllers"

#js file name to which the controllers will be compiled
controllersFile = out+"controllers.js"

coffees = "*.coffee"

#child process variable
{exec} = require 'child_process'

#generates docs for sources
#for this command docco ( https://github.com/jashkenas/docco ) should be installed
#
#pygments should also be installed
#in Linux it can be installed by
# sudo easy_install pygments
makeDocs = ->
  console.log "Documentation generation started"

  #documenting this Cakefile
  exec "docco #{path}Cakefile", (err, stdout, stderr) ->
    #throws errors if there are any
    throw err if err
    #prints log
    console.log stdout + stderr

  #document coffees in root folder
  exec "docco #{path}/#{coffees}", (err, stdout, stderr) ->
    #throws errors if there are any
    throw err if err
    #prints log
    console.log stdout + stderr

  #document collab
  exec "docco #{collab}/#{coffees}", (err, stdout, stderr) ->
    #throws errors if there are any
    throw err if err
    #prints log
    console.log stdout + stderr

  #document models
  exec "docco #{models}/#{coffees}", (err, stdout, stderr) ->
    #throws errors if there are any
    throw err if err
    #prints log
    console.log stdout + stderr

  #document views
  exec "docco #{views}/#{coffees}", (err, stdout, stderr) ->
    #throws errors if there are any
    throw err if err
    #prints log
    console.log stdout + stderr

  #document controllers
  exec "docco #{controllers}/#{coffees}", (err, stdout, stderr) ->
    #throws errors if there are any
    throw err if err
    #prints log
    console.log stdout + stderr


  console.log "Documentation generation completed"


#FUNCTIONS THAT ARE USED IN TASKS
#---------

test = ->
  console.log "Testing started"
  console.log "nothing to test yet!"
  console.log "Testing completed"


compile = ->
  console.log "Compilation started"

  #compiles an app
  exec "coffee  --compile --output #{out} #{app}", (err, stdout, stderr) ->
    #throws errors if there are any
    throw err if err
    #prints log
    console.log stdout + stderr

  #compiles and joins models in single js file
  exec "coffee  --join #{collabFile} --compile --output #{out} #{collab}", (err, stdout, stderr) ->
    #throws errors if there are any
    throw err if err
    #prints log
    console.log stdout + stderr


  #compiles and joins models in single js file
  exec "coffee  --join #{modelsFile} --compile --output #{out} #{models}", (err, stdout, stderr) ->
    #throws errors if there are any
    throw err if err
    #prints log
    console.log stdout + stderr

  #compiles and joins views in single js file
  exec "coffee  --join #{viewsFile} --compile --output #{out} #{views}", (err, stdout, stderr) ->
    throw err if err
    console.log stdout + stderr

  #compiles and joins controllers in single js file
  exec "coffee --join #{controllersFile}  --compile --output #{out} #{controllers}", (err, stdout, stderr) ->
    throw err if err
    console.log stdout + stderr

  #compiles mockdata
  exec "coffee  --compile --output #{out} #{mock}", (err, stdout, stderr) ->
    #throws errors if there are any
    throw err if err
    #prints log
    console.log stdout + stderr


  console.log "Compilation completed"






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
 # makeDocs()

#makes cleanup,compile and documenting
task 'build', 'Builds project from src/*.coffee to lib/*.js', ->
  console.log "Build task started"

  test()
  compile()
  makeDocs()
  console.log "Build task completed"


