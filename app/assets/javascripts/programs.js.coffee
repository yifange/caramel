# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $.fn.editable.defaults.mode = 'inline'
  $('#all-teachers').editable({
    select2: {
      width: "100%",
      multiple: true
    }
  })
# $ ->
#   $.fn.editable.defaults.mode = 'inline'
#   $('#hahaha').editable({
#     # name: 'instrument'
#     url: '/post',
#     title: 'Enter username'
#     source: {
#       {id: 's2', text: 'Great'}
#
#     }
#     select2: {
#       multiple: true
#     }
#   })
      # width: "1050px",
      # url: '/program/get_teachers'
      # source: ->
      #   result = undefined
      #   $.ajax({
      #     type: "GET",
      #     url: "/programs/get_teachers",
      #     dataType: "json",
      #     success: (response) ->
      #       alert("Success" + response)
      #       result = response
      #   })
      #   return result


      # source: [
      #   {id: 's2', text: 'Great'}]

# $ ->
#   $.fn.editable.defaults.mode = 'inline'
#   $('.all-teachers').each((ind, val) ->
#     $(val).select2({
#       width: "1050px",
#       url: '/program/get_teachers'
#     }))

  # $('#regular-total').editable({
  #   url: '/post',
  #   title: 'Enter User Name'
  # })

  # $('#group-total').editable({
  #   url: '/post',
  #   title: 'Enter User Name'
  # })

  # $('.all-instruments').each((ind, val) ->
  #   $(val).editable(prepend: true, children: [{ind, val}]))

