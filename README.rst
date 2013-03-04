===============
SemanticTasks
===============

SemanticTasks toghether with SemanticChat allow you to incorporate semantic operations into you taksmanagement.

This repository is intended to be used as git submodule for other projects (i.e. SemanticChat and Denigma), it concists of coffeescript, less and html files as well as cakefile to rule_them... to build them all.

Now the project is on very early stage so you will not see much there.
SemanticTasks is based on Coffeescript and Batman framework.
Coffeescript is just a better javscript, it is a language that is compiled to JavaScript. It is very easy to learn and it adds a lot of conveniences and syntax sugar to JS (see to http://coffeescript.org ). BatmanJS ( batmanjs.org ) is MVC framework based on CoffeeScript. Batmans has a lot of cool features that are needed to build fast, flexible and responsive applications. It has very nice binding and events system letting you create very complex logic in a small ammount of code.

The application is structured in MVC way, so there are views, controllers and models folders that contain coffeescript classes.

This coffeescript files are compiled and joined to js folder by cake (see Cakefile for more info).

There is also a documentation that is generated automaticaly on build and lies in docs folder.

For styles LESS is used. LESS is just better CSS that extend it with some extra features.
LESS is natively supported by Chrome and some other browsers but the best way to use them is to compile to CSS (see resources.css folder)



Setting up SemanticTasks
==================

1. Git clone repository::

    You can do it in your favourite git client or in console by typing:

    $ git clone https://github.com/antonkulaga/semantictasks.git

3. Set up CoffeeScript, if you have not installed it yet, you need to::

    Go to http://nodejs.org and install it. Nodejs will be used here only for coffeescript compilation.
    If you are using Ubuntu/Mint it is recommented to build Nodejs from sources because Ubuntu's repository contains outdated version of nodejs. 
    NodeJS comes with npm package manager. You can use it from the console to install all others things that are needed.

    $ npm install -g coffee-script

    $ npm install -g cake 
	
	When you are done, install and activate NodeJs and coffeescript plugins in your favourite IDE.
	
	Installes CoffeeScript itself and Cake builder that will be used to build the sources (-g parameter means that it will be installed as global, so npm will write the PATH variable for it and you will be able to call it from the console)


4. Prepare Environment::

	We also need few other tools. Mocha ( http://visionmedia.github.com/mocha/ ) and Chai ( http://chaijs.com/ ) for testing:

	$ sudo npm install -g mocha

	$ sudo npm install chai

	Coffeedoc ( https://github.com/omarkhan/coffeedoc ) for documentation generation:

	$ sudo npm install -g coffeedoc

	If you like more simple documentation style you may use docco instead (several documentation options are supported in Cakefile):

	$ sudo npm install -g docco

    
5. Build the project::

   In order to do this you should go to the project directory (where there is a file called Cakefile) and run:

   $ cake build

If you are using IntellijIDEA or similar you can set up cake as external tool and set the project directory (where the Cakefile is located) as working directory. Then you can open your run cofiguration and add this external tool to be exectuted before run/debug command, so everytime you push debug/run button all coffeescripts will be compiled, tests passes and docs generated.

6. Change SemanticTasks::

    $ git commit -am "Brief description of the change."
    $ git push origin master

7. Keep SemanticTasks Updated::

    $ git checkout master # Update to the latest version.
    $ git pull # Pull it from master.
