# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

attachProfileHandler = ->

  $.fn.editable.defaults.mode = 'inline'
  $('.email-input').editable({
    showbuttons: false,
    onblur: 'submit',
    data: ->
      alert $(this).val()
    url: "/profiles/1"
    ajaxOptions: {
      type: 'put',
      datatype: 'json',
    }
  })

$(document).ready attachProfileHandler
$(document).on "page:load", attachProfileHandler
