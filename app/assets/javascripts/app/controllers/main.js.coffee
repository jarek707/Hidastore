$ = jQuery.sub() 

$.fn.item = ->
  elementID   = $(@).data('id')
  elementID or= $(@).parents('[data-id]').data('id')
  Plug.find(elementID)

class PlugsIndex extends Spine.Controller
  className: 'sidebar'
  events:
    'click [data-type=destroy]': 'destroy'
    'click [data-type=show]':    'show'
    'click button.new':          'new'

  constructor: ->
    log [ 'main constructor' ]
    super
    try
      #Plug.bind 'refresh change', @render
      #Plug.fetch()
    catch error
      log [ "the error:", "#{error}" ]

  deactivate: ->
    # Always keep index on page

  render: =>
    log [ 'main render' ]
    @html @view('plugs/index') items: Plug.all()

  show: (e) ->
    item = $(e.target).item()
    log [ 'main show', item.id ]
    @navigate '/plugs', item.id

  edit: (e) ->
    log [ 'main edit' ]
    item = $(e.target).item()
    @navigate '/plugs', item.id, 'edit'
    
  destroy: (e) ->
    item = $(e.target).item()
    item.destroy() if confirm('Sure?')
    
  new: ->
    @navigate '/plugs/new'

class App.AllApp extends Spine.Controller
  className: "allApp"

  constructor: ->
    super
    plugsIndex = new PlugsIndex
    plugs      = new App.Plugs

    Plug.fetch()
    Plug.bind 'refresh change', plugsIndex.render

    @routes
      '/plugs': (params) ->
        log [ 'in index call ' , params]
        plugs.index.active(params)
      '/plugs/new': (params) ->
        log [ 'in new index call ' , params]
        plugs.new.active(params)
      '/plugs/:id': (params) ->
        log [ 'in call ' , params]
        plugs.show.active(params)

    @append plugsIndex, $("<div class='divUpDown'>"), plugs
