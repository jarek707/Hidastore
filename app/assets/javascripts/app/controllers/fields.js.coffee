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
    'submit form.new': 'submit'

  deactivate: ->
    
  constructor: ->
    super
    @active @render

  active: ( params ) ->
    super
    
  render: (params) ->
    @plug_id = params.id
    @item = 
      plug_id: params.id
      helper : { 
        subSelect: ( domId, val ) ->
          App.Selects.getText domId,val
      }

    @html @view('fields/new') @item
    App.Selects.init()

  back: ->
    @navigate '/fields', @plug_id

  submit: (e) ->
    e.preventDefault()
    Field.fromForm(e.target).save()
    #@navigate '/plugs', @plug_id

class Edit extends Spine.Controller
  className: 'fields edit'
  events:
    'submit form.field': 'submit'

  constructor: ->
    super
    @active (params) ->
      @change(@plug_id = params.id)

  change: (id) ->
    @item = Field.find(id)
    @render()
    
  render: ->
    log [ ' in edit render fields ' , @item , @el ]
    @html @view('fields/edit')(@item)
    App.Selects.init()

  back: ->
    @navigate '/fields'

  submit: (e) ->
    e.preventDefault()
    @item.fromForm(e.target).save()
    #@navigate '/plugs', @plug_id

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
    #(new Edit {el: @el}).active @id
    #new Edit {el: @el}
    #@navigate '/fields', @id, 'edit'

  submit: (e) -> 
    e.preventDefault()
    Field.fromForm(e.target).save()
    false

class Index extends Spine.Controller
  className:'fields index'

  events:
    'click .show.item': 'edit'
    'click [data-type=showHide]': 'showHide'

  showHide:(e) ->
    targetDiv = $($(e.target).attr('target'))
    if $(targetDiv).is ":hidden"
      $(targetDiv).slideDown 'fast'
      $(e.target).fadeOut 'fast', -> $(this).addClass('opened').fadeIn 'slow'
    else
      $(targetDiv).fadeOut 'fast'
      $(e.target).fadeOut 'fast', -> $(this).removeClass('opened').fadeIn 'slow'

  constructor: ->
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

    #@navigate '/fields/new', params.id
    #@navigate '/plugs', params.id
    
  edit: (e) ->
    log $(e.target).parents('[data-id]').data('id')
    @navigate '/fields', $(e.target).parents('[data-id]').data('id'), 'edit'


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
    '/plugs/:id/fields': 'index'
    
  default: 'index'
  className: 'stack fields'

Fields = App.Fields
