#= require json2
#= require jquery
#= require spine
#= require spine/manager
#= require spine/ajax
#= require spine/route
#= require ./lib/relation.js

#= require_tree ./lib
#= require_self
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./controllers/helper
#= require_tree ./views

class App extends Spine.Controller
  constructor: ->
    super
    
    # Initialize controllers:
    @append(@items  = new App.Plugs)
    #@append(@fields = new App.Fields)
    #  ...
    
    Spine.Route.setup()    

window.App = App


