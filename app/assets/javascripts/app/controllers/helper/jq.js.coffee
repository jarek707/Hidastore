class JQ
  @tpl = 
    option: ( id, val ) ->
      '<option value="' + id + '">' + val + '</option>'
    id_input: ( type, id ) ->
      '<input type="' + type + '" name="id" value="' + id + '"></input>'

  @reindex_by_id: (arg, label ) ->
    label ?= 'description'
    rO = {}
    rO[o.id] = o['description'] for o in arg
    return rO
  
  @get: ( url, cb ) ->
      $.ajax(
        type: 'GET',
        url: url
        dataType: 'json',
        success: (data) ->
          cb(data)
      )

  @show_hide: (e) ->
    targetDiv = $($(e.target).attr('target'))
    if $(e.target).hasClass('opened')
      $(targetDiv).fadeOut 'fast'
      $(e.target).fadeOut 'fast', -> $(this).removeClass('opened').fadeIn 'slow'
    else
      $(targetDiv).slideDown 'fast'
      $(e.target).fadeOut 'fast', -> $(this).addClass('opened').fadeIn 'slow'

  @set_edit: (e) ->
    e.fadeOut 'fast', -> e.find('.addField').addClass('goBack').fadeIn 'slow'

  @show_divider: ( show_it ) ->
    if show_it is false
      $('#app .main .leftRight').hide()
    else 
      $('#app .main .leftRight').show()

window.JQ = JQ
