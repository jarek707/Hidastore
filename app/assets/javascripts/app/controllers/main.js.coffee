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

  constructor: ->
    super

  render: (params) =>
    @html @view('plugs/index') items: Plug.all()

  renderPlug: ->
    # HACK - need to jump start plug controller, works for now
    if (match = Spine.Route.path.match(/\/plugs\/(\d*)/))
      @navigate '/plugs', match.pop()
    
  show: (e) ->
    @navigate '/plugs', $(e.target).item().id

  new: ->
    @navigate '/plugs/new'

  edit: (e) ->
    @navigate '/plugs', $(e.target).item().id, 'edit'
    
  destroy: (e) ->
    item = $(e.target).item()
    if confirm('Sure?')
      item.destroy() 
      @navigate '/plugs/init'
    
class App.AllApp extends Spine.Controller
  className: "allApp"

  constructor: ->
    super
    @html @view('layout')

    Plug.fetch()

    $('.app .allApp .fields').ready( ->
      Plug.bind 'refresh change',
             ( new App.PlugsIndex { el: $ '.sidebar' } ).render
      plugs  = new App.Plugs      { el: $ '.plugs'   }
      fields = new App.Fields     { el: $ '.fields'  }
      fields.plugs = plugs
    )
