$ = jQuery.sub()
Plug  = App.Plug
Field = App.Field

$.fn.item = ->
  elementID   = $(@).data('id')
  elementID or= $(@).parents('[data-id]').data('id')
  Plug.find(elementID)

$.fn.fieldItem = ->
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
    @html @view('plugs/new')

  back: ->
    @navigate '/plugs'

  submit: (e) ->
    e.preventDefault()
    plug = Plug.fromForm(e.target).save()
    @navigate '/plugs/new'

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
    #@navigate '/plugs'

class Show extends Spine.Controller
  events:
    'click [data-type=edit]': 'edit'
    'click [data-type=back]': 'back'
    'click [data-type=destroyField]': 'destroyField'
    'click [data-type=destroy]': 'destroy'
    'click [data-type=editField]': 'editField'
    'click [data-type=newField]': 'newField'
    'submit form.field': 'saveField'

  constructor: ->
    super
    O = @
    @active (params) ->
      log [ params ]
      Field.fetch({plug_id:params.id})
      setTimeout ( -> O.change(params.id) ), 300 # TODO for now it works

  change: (id) ->
    #try 
    if  true
      Field.bind 'refresh change', @proxy @render
      Plug.bind  'refresh change', @proxy @render
      @item = Plug.find(id)
      @render()
    #catch e
    #  log [ 'Waiting for data or somthn', e ]

  render: ->
    @item.helper = 
      subSelect: ( domId, val ) ->
        App.Selects.getText domId,val

    @html @view('plugs/show') @item
    App.Selects.init()

  edit: ->
    @navigate '/plugs', @item.id, 'edit'

  editField: (e) ->
    # Cleanup after last incompleted open
    $('#rightPane div.text').show()
    $('#rightPane div.input form li').remove()

    ( new App.El e.target,'data-id' ).copy_html().text_to_input().hide_text()

  saveField: (e) ->
    e.preventDefault()
    $.extend( Field.fromForm(e.target), { plug_id : @item.id } ).save()
    @navigate '/plugs' , @item.id

  destroy: (e) ->
    item = $(e.target).item()
    item.destroy() if confirm('sure?')
    @navigate '/plugs'

  destroyField: (e) ->
    item = $(e.target).parent().fieldItem()
    @proxy(item.destroy()) if confirm('sure?')
    
class Index extends Spine.Controller
  events:
    'click [data-type=edit]':    'edit'
    'click [data-type=destroy]': 'destroy'
    'click [data-type=show]':    'show'
    'click [data-type=new]':     'new'

  constructor: ->
    super
    try
      Plug.fetch()
      Plug.bind 'refresh change', @render
    catch error
      log [ "the error:", "#{error}" ]

  deactivate: ->
    # Always keep index on page

  render: =>
    try 
      plugs  = Plug.all()
      @html @view('plugs/index')(plugs: plugs)
    catch e
      log [ e ]

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
