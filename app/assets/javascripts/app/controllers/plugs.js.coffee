$ = jQuery.sub()
Plug = App.Plug

$.fn.item = ->
  elementID   = $(@).data('id')
  elementID or= $(@).parents('[data-id]').data('id')
  Plug.find(elementID)

class New extends Spine.Controller
  events:
    'click [data-type=back]': 'back'
    'submit form': 'submit'
    
  constructor: ->
    super
    @active @render
    
  render: ->
    @html @view('plugs/new')

  back: ->
    @navigate '/plugs'

  submit: (e) ->
    e.preventDefault()
    plug = Plug.fromForm(e.target).save()
    @navigate '/plugs', plug.id if plug

class Edit extends Spine.Controller
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
    @navigate '/plugs'

  submit: (e) ->
    e.preventDefault()
    @item.fromForm(e.target).save()
    @navigate '/plugs'

class Show extends Spine.Controller
  events:
    'click [data-type=edit]': 'edit'
    'click [data-type=back]': 'back'

  constructor: ->
    super
    @active (params) ->
      @change(params.id)

  change: (id) ->
    @item = Plug.find(id)
    @render()

  render: ->
    @html @view('plugs/show')(@item)

  edit: ->
    @navigate '/plugs', @item.id, 'edit'

  back: ->
    @navigate '/plugs'

class Index extends Spine.Controller
  events:
    'click [data-type=edit]':    'edit'
    'click [data-type=destroy]': 'destroy'
    'click [data-type=show]':    'show'
    'click [data-type=new]':     'new'

  constructor: ->
    super
    Plug.bind 'refresh change', @render
    Plug.fetch()
    
  render: =>
    plugs = Plug.all()
    @html @view('plugs/index')(plugs: plugs)
    
  edit: (e) ->
    item = $(e.target).item()
    @navigate '/plugs', item.id, 'edit'
    
  destroy: (e) ->
    item = $(e.target).item()
    item.destroy() if confirm('Sure?')
    
  show: (e) ->
    item = $(e.target).item()
    @navigate '/plugs', item.id
    
  new: ->
    @navigate '/plugs/new'
    
class App.Plugs extends Spine.Stack
  controllers:
    index: Index
    edit:  Edit
    show:  Show
    new:   New
    
  routes:
    '/plugs/new':      'new'
    '/plugs/:id/edit': 'edit'
    '/plugs/:id':      'show'
    '/plugs':          'index'
    
  default: 'index'
  className: 'stack plugs'