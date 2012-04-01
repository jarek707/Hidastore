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
    try
      #Plug.bind 'refresh change', @render
      #Plug.fetch()
    catch error
      log [ "the error:", "#{error}" ]

  deactivate: ->
    # Always keep index on page

  render: =>
    log [ ' plugs render  from ' ]
    @html @view('plugs/index') items: Plug.all()

  show: (e) ->
    item = $(e.target).item()
    @navigate '/plugs', item.id

  edit: (e) ->
    item = $(e.target).item()
    @navigate '/plugs', item.id, 'edit'
    
  destroy: (e) ->
    item = $(e.target).item()
    item.destroy() if confirm('Sure?')
    
  new: ->
    log [ 'nav to new plug ']
    @navigate '/plugs/new'

class App.AllApp extends Spine.Controller
  className: "allApp"

  constructor: ->
    super
    plugsIndex = new App.PlugsIndex

    Plug.fetch()
    Plug.bind 'refresh change', plugsIndex.render

    fields = null
    plugs  = null

    @append plugsIndex, $("<div class='divUpDown'/><div class='main'><div class='plugs'/><div class='leftRight' /><div class='fields' /></div>")

    setTimeout ( -> 
      plugs  = new App.Plugs  { el: $ '.plugs'  } 
      fields = new App.Fields { el: $ '.fields' } ) , 100

  controllers:
    index: App.PlugsIndex
    
  routes:
    '/plugs':      'index'
    '/plugsroot': 'index'
