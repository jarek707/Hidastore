$ = jQuery.sub()

MainPlug  = {}
ChildPlug = {}
mainplug  = ''
childplug = ''

$.fn.item = ->
  elementID   = $(@).data('id')
  elementID or= $(@).parents('[data-id]').data('id')
  ChildPlug.find(elementID)

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

    @html @view("childplug/head")
    JQ.set_edit @el
    @append @view("childplug/new") @item
    App.Selects.init()

  back: ->
    @navigate "/#{childplug}", Index.plug_id

  submit: (e) ->
    e.preventDefault()
    ChildPlug.fromForm(e.target).save()
    ChildPlug.fetch()
    @navigate "/#{childplug}/", Index.plug_id

  show_hide: (e) ->
      JQ.show_hide(e)

  to_index: ->
    @navigate "/#{childplug}", Index.plug_id

class Edit extends Spine.Controller
  className: 'edit'
  events:
    'submit form.field':          'submit'
    'click [data-type=showHide]': 'show_hide'
    'click [data-type=new]':      'to_index'

  constructor: ->
    super
    @active (params) ->
      @change params.id

  change: (id) ->
    @item = ChildPlug.find(id)
    @render()
    
  render: ->
    @html   @view("childplug/head")
    @append @view('childplug/edit')(@item)
    JQ.set_edit @el
    App.Selects.init()

  back: ->
    @navigate "/#{childplug}"

  submit: (e) ->
    e.preventDefault()
    @item.fromForm(e.target).save()
    @navigate "/#{childplug}", Index.plug_id

  show_hide: (e) ->
      JQ.show_hide(e)

  to_index: ->
    @navigate "/#{childplug}", Index.plug_id

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
      childItems : MainPlug.find(Index.plug_id)[childplug]().all()
      plug_id    : Index.plug_id
      helper     : { 
        subSelect: ( domId, val ) ->
          App.Selects.getText domId,val
      }

    @html @view('childplug/head')
    @append @view('childplug/index')(@item)

  show_hide: (e) ->
    JQ.show_hide(e)

  new: (e) ->
    @navigate "/#{childplug}", Index.plug_id, 'new'

  edit: (e) ->
    item = $(e.target).item()
    @navigate "/#{childplug}", item.plug_id, 'edit', item.id

  destroy: (e) ->
    e.preventDefault()
    item = $(e.target).item()
    if confirm('sure?')
      item.destroy()
      @navigate '/plugs', Index.plug_id

class Init extends Spine.Controller
  className: 'init'

  controller: ->
    super
    JQ.show_divider false

class App.ChildPlugs extends Spine.Stack
  constructor: ->
    MainPlug  = App[App.mainplug.uc_first()]
    ChildPlug = App[App.childplug.uc_first()]
    mainplug  = App.mainplug.plur()
    childplug = App.childplug.plur()

    @.className += childplug
    @.routes["/#{childplug}/init"]         = 'init'
    @.routes["/#{childplug}/:id"]          = 'index'
    @.routes["/#{childplug}/:id/new"]      = 'new'
    @.routes["/#{childplug}/:id/edit/:id"] = 'edit'
    super

  controllers:
    index:   Index
    new:     New
    edit:    Edit
    init:    Init

  default: 'init'
  className: 'stack '
