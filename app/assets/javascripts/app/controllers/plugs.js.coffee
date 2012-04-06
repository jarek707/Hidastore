$ = jQuery.sub()
Plug  = App.Plug
Field = App.Field

$.fn.item = ->
  elementID   = $(@).data('id')
  elementID or= $(@).parents('[data-id]').data('id')
  Plug.find(elementID)

class New extends Spine.Controller
  className: 'plugs new' 
  events:
    'click [data-type=back]': 'back'
    'submit form': 'submit'
    
  constructor: ->
    super
    @active @render
    
  render: ->
    @html @view('plugs/new')

  back: ->
    @navigate '/plugs', Plug.last().id

  submit: (e) ->
    e.preventDefault()
    plug = Plug.fromForm(e.target).save()
    log [ plug.id , ' in new ', Plug.last().id ]
    @navigate '/plugs',  Plug.last().id

class Edit extends Spine.Controller
  className: 'plugs edit'
  events:
    'click [data-type=back]': 'back'
    'submit form': 'submit'
  
  constructor: ->
    super
    @active (params) ->
      @change(params.id)
      
  change: (id) ->
    @item = Plug.find(id)
    @render()
    
  render: ->
    @html @view('plugs/edit')(@item)

  back: ->
    @navigate '/plugs', @item.id

  submit: (e) ->
    e.preventDefault()
    @item.fromForm(e.target).save()
    @navigate '/plugs', @item.id

class Show extends Spine.Controller
  className: 'plugs show'
  events:
    'click [data-type=edit]': 'edit'
    
  constructor: ->
    super
    Field.fetch()
    @active (params) ->
        @change(params.id) if params

  change: (id) ->
    @item = Plug.find(id)
    @render()

  render: ->
    if @item
      $('#app .main .leftRight').show()
      @html @view('plugs/show') @item
      @navigate '/fields', @item.id

  edit: ->
    @navigate '/plugs', @item.id, 'edit'

class Init extends Spine.Controller
  constructor: ->
    super
    @active -> 
      @navigate '/fields/init'

class App.Plugs extends Spine.Stack
  constructor: ->
    App.plugsControllerInstance = @
    super

  controllers:
    edit:  Edit
    new:   New
    show:  Show
    init:  Init
    
  routes:
    '/plugs/new':      'new'
    '/plugs/init':     'init'
    '/plugs/:id/edit': 'edit'
    '/plugs/:id':      'show'
    
  default: 'init'
  className: 'stack plugs'
