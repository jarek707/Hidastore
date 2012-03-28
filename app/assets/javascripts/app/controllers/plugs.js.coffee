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
  className: 'plugs new' 
  events:
    'click [data-type=back]': 'back'
    'submit form': 'submit'
    
  constructor: ->
    super
    @active @render
    
  render: ->
    log [ ' render new ' ]
    @html @view('plugs/new')

  back: ->
    @navigate '/plugs'

  submit: (e) ->
    e.preventDefault()
    plug = Plug.fromForm(e.target).save()
    @navigate '/plugs/new'

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
    log [ ' render edit' ]
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
    'click [data-type=back]': 'back'
    'click [data-type=destroyField]': 'destroyField'
    'click [data-type=destroy]': 'destroy'
    'click [data-type=editField]': 'editField'
    'click [data-type=showHide]': 'showHide'
    'click [data-type=newField]': 'newField'
    'submit form.field': 'saveField'

  showHide:(e) ->
    targetDiv = $('#' + $(e.target).attr('target'))
    if $(targetDiv).is ":hidden"
      $(targetDiv).slideDown 'fast'
      $(e.target).fadeOut('fast', ( -> $(this).addClass('opened'); $(this).fadeIn('slow') ) )
    else
      $(targetDiv).fadeOut 'fast'
      $(e.target).fadeOut('fast', ( -> $(this).removeClass('opened'); $(this).fadeIn('slow') ) )
    
  constructor: ->
    super
    O = @
    log [ 'appending fields ' ]
    @fields = new App.Fields
    @active (params) ->
      if typeof params isnt 'undefined' 
        @change(params.id)

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
    @html @view('plugs/show') @item

    @append $("div class='leftRight'"), @fields
    @fields.index.render(@item.fields().all())

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
    
class Start  extends Spine.Controller
  className: 'plugs start'

  constructor: ->
    super
    log 'empty start'
    fields = new App.Fields
    
    Field.fetch()

  render: ->
    log 'empty render start'

class App.Plugs extends Spine.Stack
  controllers:
    edit:  Edit
    show:  Show
    new:   New
    start: Start
    
  routes:
    '/plugs/new':      'new'
    '/plugs/:id/edit': 'edit'
    '/plugs/:id':      'show'
    
  default: 'show'
  className: 'stack plugs'

#$ ->
#  app = new App {el: $("#apps")}
#  app.append( @items = new App.Plugs )
#  log [ 'in plugs spine controller' ,  app ]
