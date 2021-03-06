class Selects
  @src: false

  @loadParams: (data) ->
    $.each( data, (key, val) -> Selects.src[key] = JQ.reindex_by_id val )

  @load: ->
    if not @src
      @src = {}
      JQ.get '/params/selects', Selects.loadParams

  @init: ( form ) ->
    form ?= 'form.field'

    src = @src
    for el in $(form + " select ")
      do (el) ->
        $.each(src[el.name], (id,val) -> $(el).append( JQ.tpl.option id,val) )

  @getText: ( selId, val ) ->
    return if @src[selId] then @src[selId][val] else 'noLabel'

class ElContainer
  container: false

  constructor: ( container ) ->
    if typeof container is 'string'
      @container = $ container
    else
      @container = container

  @get_container: ->
    @container

  @get_by_attr: ( anc, atr ) ->
    true while typeof anc.attr( atr ) is 'undefined' and ( anc = anc.parent() ).length
    if anc.length then anc else false

  set_selects: ->
    Selects.init()
    @

  restore_to_text: ->
    @container.parent().find('div.text').show()
    @container.parent().find('div.input form').remove()
    @

  hide_text: (target) ->
    target ?= 'div.text'
    @container.find(target).hide()

  copy_html: ( html, to, addId ) ->
    to    ?= 'div.input'
    addId ?= true

    outter = @container.find(to).html html
    if addId
      outter.append JQ.tpl.id_input( 'hidden', @container.attr 'data-id' )
    @

  text_to_input: ( from, to ) ->
    from ?= 'div.text'
    to   ?= 'div.input'

    @set_input( el, from ) for el in @container.find(to).find ':input'
    return @

  set_input: ( inEl, from ) ->
    if inEl.name isnt ''
      #log [ 'set in put ' , inEl, from, @container.find(from + ' li.' + inEl.name).attr('sel_id') ]
      switch inEl.type
        when 'select-one'
          $(inEl).val @container.find(from + ' li.' + inEl.name).attr 'sel_id'
        when 'text'
          $(inEl).val @container.find(from + ' li.' + inEl.name).html()

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
window.App.Selects = Selects 
