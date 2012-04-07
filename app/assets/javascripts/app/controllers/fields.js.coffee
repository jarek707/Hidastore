$ = jQuery.sub()
Field = App.Field

$.fn.item = ->
  elementID   = $(@).data('id')
  elementID or= $(@).parents('[data-id]').data('id')
  Field.find(elementID)

class New extends Spine.Controller
  className: 'new'

  events:
    'click [data-type=back]': 'back'
    'submit form.new': 'submit'
    'click [data-type=showHide]': 'show_hide'
    'click [data-type=new]':      'to_index'

  constructor: ->
    super
    @active @render

  render: (params) ->
    @item = 
      plug_id: Index.plug_id

    @html @view('fields/head')
    JQ.set_edit @el
    @append @view('fields/new') @item
    App.Selects.init()

  back: ->
    @navigate '/fields', Index.plug_id

  submit: (e) ->
    e.preventDefault()
    Field.fromForm(e.target).save()
    Field.fetch()
    @navigate '/fields', Index.plug_id

  show_hide: (e) ->
      JQ.show_hide(e)

  to_index: ->
    @navigate '/fields', Index.plug_id

class Edit extends Spine.Controller
  className: 'edit'
  events:
    'submit form.field': 'submit'
    'click [data-type=showHide]': 'show_hide'
    'click [data-type=new]':      'to_index'

  constructor: ->
    super
    @active (params) ->
      @change params.id

  change: (id) ->
    @item = Field.find(id)
    @render()
    
  render: ->
    @html   @view('fields/head')
    @append @view('fields/edit')(@item)
    JQ.set_edit @el
    App.Selects.init()

  back: ->
    @navigate '/fields'

  submit: (e) ->
    e.preventDefault()
    @item.fromForm(e.target).save()
    @navigate '/fields', Index.plug_id

  show_hide: (e) ->
      JQ.show_hide(e)

  to_index: ->
    @navigate '/fields', Index.plug_id

class Index extends Spine.Controller
  plug_id: -1
  className:'index'

  events:
    'click [data-type=new]':      'new'
    'click [data-type=showHide]': 'show_hide'
    'click [data-type=destroy]' : 'destroy'
    'click [data-type=edit]'    : 'edit'

  constructor: ->
    super
    @active (params) ->
      Index.plug_id = params.plug_id or params.id
      @render() if Index.plug_id > -1

  render: ->
    @item = 
      fields : Plug.find(Index.plug_id).fields().all()
      plug_id: Index.plug_id
      helper : { 
        subSelect: ( domId, val ) ->
          App.Selects.getText domId,val
      }

    @html @view('fields/head')
    @append @view('fields/index')(@item)

  show_hide: (e) ->
    JQ.show_hide(e)

  new: (e) ->
    @navigate '/fields', Index.plug_id, 'new'

  edit: (e) ->
    item = $(e.target).item()
    @navigate '/fields', item.plug_id, 'edit', item.id

  destroy: (e) ->
    e.preventDefault()
    item = $(e.target).item()
    if confirm('sure?')
      item.destroy()
      @navigate '/plugs', Index.plug_id

class Init extends Spine.Controller
  controller: ->
    super
    JQ.show_divider false

class App.Fields extends Spine.Stack
  controllers:
    index:   Index
    new:     New
    edit:    Edit
    init:    Init

  routes:
    '/fields/init'         : 'init'
    '/fields/:id'          : 'index'
    '/fields/:id/new'      : 'new'
    '/fields/:id/edit/:id' : 'edit'
    
  default: 'init'
  className: 'stack fields'

Fields = App.Fields
