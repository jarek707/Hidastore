$ = jQuery.sub()
User = App.User

$.fn.item = ->
  elementID   = $(@).data('id')
  elementID or= $(@).parents('[data-id]').data('id')
  User.find(elementID)

class New extends Spine.Controller
  events:
    'click [data-type=back]': 'back'
    'submit form': 'submit'
    
  constructor: ->
    super
    @active @render
    
  render: ->
    @html @view('users/new')

  back: ->
    @navigate '/users'

  submit: (e) ->
    e.preventDefault()
    user = User.fromForm(e.target).save()
    @navigate '/users', user.id if user

class Edit extends Spine.Controller
  events:
    'click [data-type=back]': 'back'
    'submit form': 'submit'
  
  constructor: ->
    super
    @active (params) ->
      @change(params.id)
      
  change: (id) ->
    @item = User.find(id)
    @render()
    
  render: ->
    @html @view('users/edit')(@item)

  back: ->
    @navigate '/users'

  submit: (e) ->
    e.preventDefault()
    @item.fromForm(e.target).save()
    @navigate '/users'

class Show extends Spine.Controller
  events:
    'click [data-type=edit]': 'edit'
    'click [data-type=back]': 'back'

  constructor: ->
    super
    @active (params) ->
      @change(params.id)

  change: (id) ->
    @item = User.find(id)
    @render()

  render: ->
    @html @view('users/show')(@item)

  edit: ->
    @navigate '/users', @item.id, 'edit'

  back: ->
    @navigate '/users'

class Index extends Spine.Controller
  events:
    'click [data-type=edit]':    'edit'
    'click [data-type=destroy]': 'destroy'
    'click [data-type=show]':    'show'
    'click [data-type=new]':     'new'

  constructor: ->
    super
    User.bind 'refresh change', @render
    User.fetch()
    
  render: =>
    users = User.all()
    @html @view('users/index')(users: users)
    
  edit: (e) ->
    item = $(e.target).item()
    @navigate '/users', item.id, 'edit'
    
  destroy: (e) ->
    item = $(e.target).item()
    item.destroy() if confirm('Sure?')
    
  show: (e) ->
    item = $(e.target).item()
    @navigate '/users', item.id
    
  new: ->
    @navigate '/users/new'
    
class App.Users extends Spine.Stack
  controllers:
    index: Index
    edit:  Edit
    show:  Show
    new:   New
    
  routes:
    '/users/new':      'new'
    '/users/:id/edit': 'edit'
    '/users/:id':      'show'
    '/users':          'index'
    
  default: 'index'
  className: 'stack users'