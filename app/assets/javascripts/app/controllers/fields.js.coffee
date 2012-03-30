$ = jQuery.sub()
Field = App.Field

$.fn.item = ->
  elementID   = $(@).data('id')
  elementID or= $(@).parents('[data-id]').data('id')
  Field.find(elementID)

class New extends Spine.Controller
  className: 'fields new'

  events:
    'click [data-type=back]': 'back'
    'submit form': 'submit'

  deactivate: ->
    
  constructor: ->
    super
    @active @render
    
  render: (params) ->
    @item = 
      plug_id: params.id
      helper : { 
        subSelect: ( domId, val ) ->
          App.Selects.getText domId,val
      }

    @html @view('fields/new') @item
    App.Selects.init()

  back: ->
    @navigate '/fields'

  submit: (e) ->
    e.preventDefault()
    Field.fromForm(e.target).save()
    @navigate '/fields/new'

class Edit extends Spine.Controller
  className: 'fields edit'
  events:
    'submit form': 'submit'

  constructor: ->
    super
    @active (id) ->
      @change(id)

  change: (id) ->
    @item = Field.find(id)
    @render()
    
  render: ->
    @html @view('fields/edit')(@item)
    App.Selects.init()

  back: ->
    @navigate '/fields'

  submit: (e) ->
    e.preventDefault()
    @item.fromForm(e.target).save()
    @navigate '/fields'

class Index extends Spine.Controller
  className:'fields index'

  constructor: ->
    Field.fetch()
    Field.bind 'refresh change', @proxy @active
    super
    @active (params) ->
      @change(params)

  change: (params) ->
    @render(params)

  deactivate: ->

  render: (params) ->
    return if !(@item = fields: App.plugItem).fields

    @item.helper = 
      subSelect: ( domId, val ) ->
        App.Selects.getText domId,val

    @html @view('fields/index')(@item)
    (new Show {el: @el.find "[data-id=#{f.id}]"}).active f.id for f in @item.fields
    @navigate '/fields/new', params.id

class Show extends Spine.Controller
  className:'fields show'
  events:
    'click [data-type=editField]': 'edit'
    'click [data-type=destroyField]': 'destroy'
    'submit form.field': 'submit'

  destroy: (e) ->
    item = $(e.target).item()
    item.destroy() if confirm('Sure?')

  constructor: ->
    super
    @active (params) ->
      @change(params)

  change: (params) ->
    @render(params)

  render: (id) ->
    @item = {fld: Field.find(id)}
    @id = id

    @item.helper = 
      subSelect: ( domId, val ) ->
        App.Selects.getText domId,val

    @html @view('fields/show') @item

  edit: ->
    (new Edit {el: @el}).active @id
    #new Edit {el: @el}
    #@navigate '/fields', @id, 'edit'

  submit: (e) -> 
    e.preventDefault()
    Field.fromForm(e.target).save()
    false

class App.Fields extends Spine.Stack
  controllers:
    index: Index
    show:  Show
    new:   New
    edit:  Edit 

    
  routes:
    '/fields/new/:id':  'new'
    '/fields/:id/edit': 'edit'
    '/fields/:id':      'show'
    '/fields/plug/:id': 'index'
    
  default: 'index'
  className: 'stack fields'
