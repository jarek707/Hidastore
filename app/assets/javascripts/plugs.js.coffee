Trigger =
  edit_in_progress:
    false

  find_ancestor_with_attribute: ( anc, atr ) ->
    true while typeof anc.attr( atr ) is 'undefined' and ( anc = anc.parent() ).length
    return if anc.length then anc else false

  ajax_update_return: ( wrap_id, data ) ->
    $("#edit_field").remove()
    $(wrap_id + " button.update").hide()
    $(wrap_id + " ul.show").show()
    if typeof data is 'undefined'
      alert  ("Error was encountered when updating record.")
    else
      $(wrap_id + " ul.show li.field_#{key}").html "#{value}" for key,value of data

  buttons: (arg) ->
    elm = $ arg

    switch elm.attr('class')
      when "edit"
        if ( elm = @find_ancestor_with_attribute elm, 'field_id' )
          if @edit_in_progress
            $("#edit_field").remove()
            $("button.update").hide()
            $("ul.show.text").show()

          @edit_in_progress = true
          wrap_id = "#show_wrap" + elm.attr("field_id")
          $(wrap_id + " button.update").show()
          $(wrap_id + " ul.show").hide()
          $(wrap_id + " ul.show.form").prepend("<form id='edit_field'>" + $("div.fields_wrap").html() + "</form>").show()
          $(wrap_id + " ul.show.form li.val input#" + $(el).attr('class').substr 4 ).val($(el).html()) for el in $(wrap_id + " ul.show.text li.val")

      when "update"
        if ( elm = @find_ancestor_with_attribute elm, 'field_id' )
          thisO = @
          $.ajax {
            type: "PUT",
            url: $("form.new_field").attr('action') + '/' + elm.attr('field_id'),
            data: $("#edit_field").serialize(),
            dataType: "json",
            success: (data) ->
              thisO.ajax_update_return( "#show_wrap" + elm.attr('field_id') , data )
              @edit_in_progress = false
            error: (data) ->
              thisO.ajax_update_return( "#show_wrap" + elm.attr 'field_id' )
          }

      when "add" then $('ul.show.add_field').show()

      when "delete" 
        if (elm = @find_ancestor_with_attribute elm, 'field_id' )
          $.ajax {
            type: "DELETE",
            url: $("form.new_field").attr('action') + '/' + elm.attr('field_id'),
            dataType: "json",
            success: ->
              $( "#show_wrap" + elm.attr 'field_id' ).remove()
            error: -> 
              alert("There was a problem when deleting the item")
          }

      else 
        console.debug  "This button has no class."
      
setTimeout ( -> $(":button").bind "click",  -> Trigger.buttons(this) ) , 300
setTimeout ( -> $('ul.add_field #field_label').focus() ), 300
