$ = jQuery.sub()
Field = App.Field

$.fn.item = ->
  elementID   = $(@).data('id')
  elementID or= $(@).parents('[data-id]').data('id')
  Field.find(elementID)

class New extends Spine.Controller
  events:
    'click [data-type=back]': 'back'
    'submit form': 'submit'
    
  constructor: ->
    super
    @active @render
    
  render: ->
    @html @view('fields/new')

  back: ->
    @navigate '/fields'

  submit: (e) ->
    e.preventDefault()
    field = Field.fromForm(e.target).save()
    @navigate '/fields', field.id if field

class Edit extends Spine.Controller
  events:
    'click [data-type=back]': 'back'
    'submit form': 'submit'
  
  constructor: ->
    super
    @active (params) ->
      @change(params.id)
      
  change: (id) ->
    @item = Field.find(id)
    @render()
    
  render: ->
    @html @view('fields/edit')(@item)

  back: ->
    @navigate '/fields'

  submit: (e) ->
    e.preventDefault()
    @item.fromForm(e.target).save()
    @navigate '/fields'

class Show extends Spine.Controller
  events:
    'click [data-type=edit]': 'edit'
    'click [data-type=back]': 'back'

  constructor: ->
    super
    @active (params) ->
      @change(params.id)

  change: (id) ->
    @item = Field.find(id)
    @render()

  render: ->
    @html @view('fields/show')(@item)

  edit: ->
    @navigate '/fields', @item.id, 'edit'

  back: ->
    @navigate '/fields'

class Index extends Spine.Controller
  events:
    'click [data-type=edit]':    'edit'
    'click [data-type=destroy]': 'destroy'
    'click [data-type=show]':    'show'
    'click [data-type=new]':     'new'

  constructor: ->
    super
    Field.bind 'refresh change', @render
    Field.fetch()
    
  render: =>
    fields = Field.all()
    @html @view('fields/index')(fields: fields)
    
  edit: (e) ->
    item = $(e.target).item()
    @navigate '/fields', item.id, 'edit'
    
  destroy: (e) ->
    item = $(e.target).item()
    item.destroy() if confirm('Sure?')
    
  show: (e) ->
    item = $(e.target).item()
    @navigate '/fields', item.id
    
  new: ->
    @navigate '/fields/new'
    
class App.Fields extends Spine.Stack
  controllers:
    index: Index
    edit:  Edit
    show:  Show
    new:   New
    
  routes:
    '/fields/new':      'new'
    '/fields/:id/edit': 'edit'
    '/fields/:id':      'show'
    '/fields':          'index'
    
  default: 'index'
  className: 'stack fields'