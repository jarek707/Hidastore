$ = jQuery.sub()
Plug  = App.Plug

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
    @fields = new App.Fields
    Plug.bind  'refresh change', @proxy @render
    @active (params) ->
        @change(params.id) if params

  change: (id) ->
    @item = Plug.find(id)
    App.plugItem = @item.fields().all()
    @render()

  render: ->
    if @item
      @html @view('plugs/show') @item

      @append $("div class='leftRight'"), @fields
      @navigate '/fields/plug', @item.id

  edit: ->
    @navigate '/plugs', @item.id, 'edit'

  destroy: (e) ->
    item = $(e.target).item()
    item.destroy() if confirm('sure?')
    @navigate '/plugs'

class App.Plugs extends Spine.Stack
  controllers:
    edit:  Edit
    show:  Show
    new:   New
    
  routes:
    '/plugs/new':      'new'
    '/plugs/:id/edit': 'edit'
    '/plugs/:id':      'show'
    
  default: 'show'
  className: 'stack plugs'
