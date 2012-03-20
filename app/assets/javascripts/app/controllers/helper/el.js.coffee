class Tpls
  @option: ( id, val ) ->
    "<option value='" + id + "'>" + val + "</option>"
  @id_input: ( type, id ) ->
    '<input type="' + type + '" name="id" value="' + id + '"></input>'

class SelSource
  @src: false

  @reindex_by_id: (arg) ->
    rO = {}
    rO[o.id] = o.description for o in arg
    return rO

  @reindex_data: (key, data) ->
    @src = {} if not @src
    @src[key] = @reindex_by_id data
    
  @load: ->
    if not @src
      $.ajax(
        type: 'GET',
        url: "siteparams",
        dataType: 'json',
        success: (data) ->
          $.each( data, ( (key,val) -> SelSource.reindex_data(key,val) ) )
      )

  @getText: ( selId, val ) ->
    return  @src[selId][val]

  @initSelects: ( form ) ->
      src = @src
      for el in $(form + " select ")
        do (el) ->
          $.each(src[el.name], ( (id,val) -> $(el).append(Tpls.option(id,val)) ) )

class ElContainer
  container: false

  constructor: ( container ) ->
    if typeof container is 'string'
      @container = $ container
    else
      @container = container

  @get_by_attr: ( anc, atr ) ->
    true while typeof anc.attr( atr ) is 'undefined' and ( anc = anc.parent() ).length
    return if anc.length then anc else false

  hide_text: (target) ->
    target ?= 'div.text'

    @container.find(target).hide()

  copy_html: ( from, to, addId ) ->
    from  ?= '#rightPane form ul'
    to    ?= 'form'
    addId ?= true

    outter = @container.find(to).html $(from).html()
    if addId
      outter.append( Tpls.id_input( 'hidden', @container.attr('data-id') ) )
    return @

  text_to_input: ( from, to ) ->
    from ?= 'div.text'
    to   ?= 'div.input'

    @set_input( el, from ) for el in @container.find(to).find ':input'
    return @

  set_input: ( inEl, from ) ->
    if inEl.name isnt ''
      switch inEl.type
        when 'select-one' then $(inEl).val @container.find(from + ' li.' + inEl.name).attr('sel_id')
        when 'text'       then $(inEl).val @container.find(from + ' li.' + inEl.name).html()

class El extends ElContainer
  target: false

  constructor: ( target, atr ) ->
    @target = $ target
    if typeof atr is 'undefined'
      super @target.parent()
    else
      super ( ElContainer.get_by_attr @target, atr )

window.App.El          = El
window.App.ElContainer = ElContainer
window.App.SelSource   = SelSource
SelSource.load()