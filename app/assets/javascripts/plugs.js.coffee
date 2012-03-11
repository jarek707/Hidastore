# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

Trigger =
  buttons: (arg) ->
    elm = $(arg)

    switch elm.attr('class')
      when "update"
        if typeof elm.attr('field_id') is 'undefined'
          elm = elm.parent() while typeof elm.attr('field_id') is 'undefined' and typeof elm.parent() isnt 'undefined'

        wrap_id = "#show_wrap" + elm.attr('field_id');
        $.ajax {
          type: "PUT",
          url: $("form.new_field").attr('action') + '/' + elm.attr('field_id'),
          data: $("#edit_field").serialize(),
          dataType: "json",
          success: (data) ->
            $("#edit_field").remove()
            $(wrap_id + " button.update").hide();
            $(wrap_id + " ul.show").show()
            $(wrap_id + " ul.show li.field_#{key}").html("#{value}") for key,value of data
          error: (data) -> 
            $("#edit_field").remove()
            $(wrap_id + " button.update").hide();
            $(wrap_id + " ul.show").show()
            alert  ("Error was encountered when updating record.")
        }

      when "edit"
        if typeof elm.attr('field_id') is 'undefined'
          elm = elm.parent() while typeof elm.attr('field_id') is 'undefined' and typeof elm.parent() isnt 'undefined'

        wrap_id = "#show_wrap" + elm.attr("field_id") 
        $("#show_wrap" + elm.attr("field_id") + " button.update").show();
        $(wrap_id + " ul.show").hide()
        $(wrap_id + " ul.show.form").append("<form id='edit_field'>" + $("div.fields_wrap").html() + "</form>").show()
        $(wrap_id + " ul.show.form li.val input#" + $(el).attr('class').substr(4) ).val($(el).html()) for el in $(wrap_id + " ul.show.text li.val")

      when "add" 
        console.debug elm.attr('class')
        $('ul.show.add_field').show()

      when "delete" 
        console.debug elm.attr('class')

      else 
        console.debug  "This button has no class."
      

setTimeout ( -> $(":button").bind "click",  -> Trigger.buttons(this) ) , 100
