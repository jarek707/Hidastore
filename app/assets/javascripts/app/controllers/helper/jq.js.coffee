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

window.JQ = JQ
