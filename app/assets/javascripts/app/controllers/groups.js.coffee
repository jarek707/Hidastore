$ = jQuery.sub()
Group = App.Group

$.fn.item = ->
  elementID   = $(@).data('id')
  elementID or= $(@).parents('[data-id]').data('id')
  Group.find(elementID)

class New extends Spine.Controller
  events:
    'click [data-type=back]': 'back'
    'submit form': 'submit'
    
  constructor: ->
    super
    @active @render
    
  render: ->
    @html @view('groups/new')

  back: ->
    @navigate '/groups'

  submit: (e) ->
    e.preventDefault()
    group = Group.fromForm(e.target).save()
    @navigate '/groups', group.id if group

class Edit extends Spine.Controller
  events:
    'click [data-type=back]': 'back'
    'submit form': 'submit'
  
  constructor: ->
    super
    @active (params) ->
      @change(params.id)
      
  change: (id) ->
    @item = Group.find(id)
    @render()
    
  render: ->
    @html @view('groups/edit')(@item)

  back: ->
    @navigate '/groups'

  submit: (e) ->
    e.preventDefault()
    @item.fromForm(e.target).save()
    @navigate '/groups'

class Show extends Spine.Controller
  events:
    'click [data-type=edit]': 'edit'
    'click [data-type=back]': 'back'

  constructor: ->
    super
    @active (params) ->
      @change(params.id)

  change: (id) ->
    @item = Group.find(id)
    @render()

  render: ->
    @html @view('groups/show')(@item)

  edit: ->
    @navigate '/groups', @item.id, 'edit'

  back: ->
    @navigate '/groups'

class Index extends Spine.Controller
  events:
    'click [data-type=edit]':    'edit'
    'click [data-type=destroy]': 'destroy'
    'click [data-type=show]':    'show'
    'click [data-type=new]':     'new'

  constructor: ->
    super
    Group.bind 'refresh change', @render
    Group.fetch()
    
  render: =>
    groups = Group.all()
    @html @view('groups/index')(groups: groups)
    
  edit: (e) ->
    item = $(e.target).item()
    @navigate '/groups', item.id, 'edit'
    
  destroy: (e) ->
    item = $(e.target).item()
    item.destroy() if confirm('Sure?')
    
  show: (e) ->
    item = $(e.target).item()
    @navigate '/groups', item.id
    
  new: ->
    @navigate '/groups/new'
    
class App.Groups extends Spine.Stack
  controllers:
    index: Index
    edit:  Edit
    show:  Show
    new:   New
    
  routes:
    '/groups/new':      'new'
    '/groups/:id/edit': 'edit'
    '/groups/:id':      'show'
    '/groups':          'index'
    
  default: 'index'
  className: 'stack groups'