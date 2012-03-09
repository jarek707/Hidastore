# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

Trigger =
  buttons: (arg) ->
    elm = $(arg)
    if  elm.attr('class') is "edit"
      if typeof elm.attr('field_id') is 'undefined'
        elm = elm.parent() while typeof elm.attr('field_id') is 'undefined' and typeof elm.parent() isnt 'undefined'
      console.debug [elm.attr('field_id')] 
      $('ul.show.add_field').hide()
    else
      console.debug elm.attr('class')
      $('ul.show.add_field').show()
      

setTimeout ( -> $(":button").bind "click",  -> Trigger.buttons(this) ) , 100
