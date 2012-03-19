Trigger =
  edit_in_progress: false
  config_params:    {}
  field_id:         -1

  get_ancestor_attr: ( anc, atr ) ->
    true while typeof anc.attr( atr ) is 'undefined' and ( anc = anc.parent() ).length
    return if anc.length then anc.attr atr else false

  after_delete: ( data ) ->
    console.debug  'after delete'

  after_post: ( in_container, data ) ->
    data = data[0]
    $("#field_wrap").append("<div id='show_wrap" + data.id + "' field_id='" + data.id + "'>" + $("#_field_wrap #show_wrap").html() + "</div>")
    $("#show_wrap" + data.id + " button").bind 'click', -> Trigger.buttons this 
    @after_put $("#show_wrap" + data.id), data
    $('form.new_field ul.add_field li input').val ''

  after_put: ( in_container, data ) ->
    if typeof data is 'undefined'
      alert  ("Error was encountered when updating record.")
    else
      @edit_in_progress = false
      @from_input( in_container, "#{key}", "#{value}" ) for key,value of data
    $("#edit_form").remove()
    in_container.find("ul.show").show()
   
  to_input: ( in_container, el ) ->
    if typeof el.attr('sel_id') is 'undefined'
      in_container.find("ul.show.form li.val input#" + el.attr('class').substr 4 ).val el.html()
    else
      in_container.find("ul.show.form li.val select#" + el.attr('class').substr(4) + " option[value='" + el.attr('sel_id') + "']" ).attr 'selected','selected'

  from_input: ( in_container, key , value ) ->
    el = in_container.find "ul.show.text li.field_" + key
    if typeof el.attr('sel_id') is 'undefined'
      el.html value
    else
      el.html in_container.find("ul.show.form li.field_" + key + " select option:selected").text()
      el.attr 'sel_id', value

  buttons: (arg) ->
    if field_id = @get_ancestor_attr $(arg), 'field_id'

      in_container = $ "#show_wrap" + field_id
      switch $(arg).attr('class')
        when "edit"
          if @edit_in_progress
            $("#edit_form").remove()
            $("ul.show.text").show()

          in_container.find("ul.show.text" ).hide()
          in_container.find("ul.show.form" ).prepend("<form id='edit_form'>" + $("ul.add_field").html() + "</form>").show()
          in_container.find("form li:nth-child(1) input").focus().select()
          @to_input( in_container , $ el ) for el in in_container.find("ul.show.text li.val")
          @edit_in_progress = true

          $("#edit_form button.save").bind 'click', -> Trigger.buttons this 

        when "save"
          if field_id is 'new' 
            ap = {method: 'post', url:$("form.new_field").attr('action'),                   data:$("#new_field").serialize()}
          else 
            ap = {method: 'put',  url:$("form.new_field").attr('action') + '/' + field_id , data:$("#edit_form").serialize()}

          thisO = @
          $.ajax {
            type:     ap.method, 
            url:      ap.url,
            data:     ap.data, 
            dataType: "json",
            success:  (data) -> thisO["after_" + ap.method]( in_container, data )
            error:    (data) -> thisO["after_" + ap.method]( in_container       )
          }

        when "delete" 
          if confirm "Really sure about this?" 
            $.ajax {
              type:     "DELETE",
              url:      $("form.new_field").attr('action') + '/' + field_id,
              dataType: "json",
              success:  -> $("#show_wrap" + field_id).remove()
              error:    -> alert("There was a problem when deleting the item")
            }

        when "alledit" 
          console.debug [ field_id ]

        else 
          console.debug "This button has no class."
      
  # Config data helper methods
  reindex_by_id: (arg) ->
    rO = {}
    rO[o.id] = o.description for o in arg

  set_config_params: ( data ) ->
    @config_params.fields = {}
    @config_params.fields[o.id] = o for o in data[0].fields

    ( @config_params["#{key}"] = @reindex_by_id( data[0]["#{key}"] ) if 'fields' isnt "#{key}" ) for key of data[0]

#Get config data
#$.ajax {
#  type:     'GET',
#  url:      '/siteparams/' + document.location.pathname.split('/').pop(),
# dataType: "json",
# success:  (data) -> Trigger.set_config_params data
# error:    (data) -> console.debug  "Error getting site params"
#}

#Bind buttons and focus on the first INPUT elm
setTimeout ( -> $(":button").on "click", -> Trigger.buttons this ), 600
setTimeout ( -> $('#rightPane form.new_field ul.add_field div.add_field li:nth-child(1) input').focus() ), 300
