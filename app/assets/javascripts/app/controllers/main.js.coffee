$ = jQuery.sub() 

$.fn.item = ->
  elementID   = $(@).data('id')
  elementID or= $(@).parents('[data-id]').data('id')
  Plug.find(elementID)

class App.PlugsIndex extends Spine.Controller
  className: 'sidebar'
  events:
    'click [data-type=destroy]': 'destroy'
    'click [data-type=show]':    'show'
    'click button.new':          'new'

  render: =>
    log [ Spine.Route.path, Spine.Route.path.match(/(^\/)/) ]
    @html @view('plugs/index') items: Plug.all()

  show: (e) ->
    @navigate '/plugs', $(e.target).item().id

  new: ->
    log [ 'nav to new plug ']
    @navigate '/plugs/new'

  edit: (e) ->
    @navigate '/plugs', $(e.target).item().id, 'edit'
    
  destroy: (e) ->
    item = $(e.target).item()
    item.destroy() if confirm('Sure?')
    
class App.AllApp extends Spine.Controller
  className: "allApp"

  constructor: ->
    super
    @html @view('layout')

    Plug.fetch()

    $('.app .allApp .main .fields').ready( ->
      Plug.bind 'refresh change',
             ( new App.PlugsIndex { el: $ '.sidebar' } ).render
      plugs  = new App.Plugs      { el: $ '.plugs'   }
      fields = new App.Fields     { el: $ '.fields'  }
      #Spine.Route.path =''
    )
