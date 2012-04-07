$ = jQuery.sub() 
MainPlug  = {}
mainplug  = ''
childplug = ''

$.fn.item = ->
  elementID   = $(@).data('id')
  elementID or= $(@).parents('[data-id]').data('id')
  MainPlug.find(elementID)

class App.Index extends Spine.Controller
  className: 'sidebar '
  events:
    'click [data-type=destroy]': 'destroy'
    'click [data-type=show]':    'show'
    'click button.new':          'new'

  constructor: ->
    @.className += mainplug
    super

  render: (params) =>
    @html @view('mainplug/index') items: MainPlug.all()

  show: (e) ->
    @navigate "/#{mainplug}", $(e.target).item().id

  new: ->
    @navigate "/#{mainplug}/new"
    @navigate "/#{childplug}/init"

  edit: (e) ->
    @navigate "/#{mainplug}", $(e.target).item().id, 'edit'
    
  destroy: (e) ->
    item = $(e.target).item()
    if confirm('Sure?')
      item.destroy() 
      @navigate "/#{mainplug}/init"
    
class App.AllPlug extends Spine.Controller
  className: "allPlug "

  constructor: ->
    MainPlug  = App[App.mainplug.uc_first()]
    mainplug  = App.mainplug.plur()
    childplug = App.childplug.plur()

    @.className += mainplug
    super

    MainPlug.fetch()
    @html @view('layout')

    $('.app .allApp .childplug').ready( ->
      MainPlug.bind 'refresh change', ( new App.Index { el: $ '.sidebar' } ).render
      mains  = new App.MainPlugs  { el: $ '.mainplug'  }
      childs = new App.ChildPlugs { el: $ '.childplug' }
      childs.mains = mains
    )
