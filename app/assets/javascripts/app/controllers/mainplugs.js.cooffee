$ = jQuery.sub()
MainPlug  = {}
ChildPlug = {}
mainplug  = ''
childplug = ''

$.fn.item = ->
  elementID   = $(@).data('id')
  elementID or= $(@).parents('[data-id]').data('id')
  MainPlug.find(elementID)

class New extends Spine.Controller
  className: 'new '
  events:
    'click [data-type=back]': 'back'
    'submit form': 'submit'
    
  constructor: ->
    super
    @active @render
    
  render: ->
    @html @view("mainplug/new")

  back: ->
    @navigate '/', MainPlug.last().id

  submit: (e) ->
    e.preventDefault()
    plug = MainPlug.fromForm(e.target).save()
    @navigate "/#{mainplug}",  MainPlug.last().id

class Edit extends Spine.Controller
  className: 'edit '
  events:
    'click [data-type=back]': 'back'
    'submit form': 'submit'
    'click [data-type=showHide]': 'show_hide'
  
  constructor: ->
    super
    @active (params) ->
      @change(params.id)
      
  change: (id) ->
    @item = MainPlug.find(id)
    @render()
    
  render: ->
    @html @view("mainplug/edit")(@item)

  back: ->
    @navigate "/#{mainplug}", @item.id

  submit: (e) ->
    e.preventDefault()
    @item.fromForm(e.target).save()
    @navigate "/#{mainplug}", @item.id

  show_hide: (e) ->
      JQ.show_hide(e)

class Show extends Spine.Controller
  className: 'show '
  events:
    'click [data-type=edit]': 'edit'
    'click [data-type=showHide]': 'show_hide'
    
  constructor: ->
    super
    ChildPlug.fetch()
    @active (params) ->
        @change(params.id) if params

  change: (id) ->
    @item = MainPlug.find(id)
    @render()

  render: ->
    if @item
      JQ.show_divider()
      @html @view("mainplug/show") @item
      @navigate "/#{childplug}", @item.id

  edit: ->
    @navigate "/#{mainplug}", @item.id, 'edit'

  show_hide: (e) ->
      JQ.show_hide(e)

class Init extends Spine.Controller
  constructor: ->
    super
    @active -> 
      @navigate "/#{childplug}/init"

class App.MainPlugs extends Spine.Stack
  constructor: ->
    MainPlug  = App[App.mainplug.uc_first()]
    ChildPlug = App[App.childplug.uc_first()]
    mainplug  = App.mainplug.plur()
    childplug = App.childplug.plur()

    @.className += mainplug
    @.routes["/#{mainplug}/new"]      = 'new'
    @.routes["/#{mainplug}/init"]     = 'init'
    @.routes["/#{mainplug}/:id/edit"] = 'edit'
    @.routes["/#{mainplug}/:id"]      = 'show'
    super

  controllers:
    edit:  Edit
    new:   New
    show:  Show
    init:  Init
    
  default: 'init'
  className: "stack "
