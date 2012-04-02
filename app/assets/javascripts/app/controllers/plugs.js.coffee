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
    log [ ' in new plug ' ]
    @html @view('plugs/new')

  back: ->
    log [ ' last ' , Plug.last().id ]
    @navigate '/plugs', Plug.last().id

  submit: (e) ->
    e.preventDefault()
    plug = Plug.fromForm(e.target).save()
    log [ plug.id , ' afer save  ' ]
    @navigate '/plugs', plug.id

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
    #log [ Spine.Route('plugs/39/new') ]
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
    Field.bind  'refresh change', @proxy @fieldChange
    @active (params) ->
        @change(params.id) if params

  fieldChange: (params) ->
    @change( params.plug_id ) if params.plug_id

  change: (id) ->
    @item = Plug.find(id)
    log [ 'field change' , @item.fields().all() ]
    App.plugItem = @item.fields().all()
    @render()

  render: ->
    if @item
      $('#app .main .leftRight').show()
      @html @view('plugs/show') @item
      @navigate '/plugs', @item.id, 'fields'

  edit: ->
    @navigate '/plugs', @item.id, 'edit'

  destroy: (e) ->
    item = $(e.target).item()
    item.destroy() if confirm('sure?')
    @navigate '/plugs'

class App.Plugs extends Spine.Stack
  constructor: ->
    App.plugsControllerInstance = @
    super
  controllers:
    edit:  Edit
    new:   New
    show:  Show
    
  routes:
    '/plugs/new':      'new'
    '/plugs/:id/edit': 'edit'
    '/plugs/:id':      'show'
    
  default: 'show'
  className: 'stack plugs'
