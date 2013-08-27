# # Place all the behaviors and hooks related to the matching controller here.
# # All this logic will automatically be available in application.js.
# # You can use CoffeeScript in this file: http://coffeescript.org/
#
# attachHandler = ->
#   $.fn.editable.defaults.mode = 'inline'
#   $('.instrument-input').editable({
#     url: 'programs/instrument',
#     type: 'text',
#     placeholder: 'instrument'
#   })
#
#   $('.program-input').editable({
#     url: '',
#     type: 'text',
#     placeholder: 'program'
#   })
#
#   $.fn.editable.defaults.mode = 'inline'
#   $('.region-name-input').editable({
#     url: '',
#     type: 'text',
#     placeholder: 'region name'
#   })
#
#   $.fn.editable.defaults.mode = 'inline'
#   $('.school-input').select2({
#     tags:["GWU","JHU","SJU"]
#   });
#
#   #$.fn.editable.defaults.mode = 'inline'
# 	#	$('.instrument-options').editable({
#   #})
#
# #  $('.teacher-options').editable({
# #    select2: {
# #    }
#     # ajax: {
#     #   dataType: 'jsonp',
#     #   url: "/programs/get_teachers"
#     #   data: test = (data, page) =>
#     #     return {results: $.map(data, (teacher, i) =>
#     #       return {id: teacher.id, text: teacher.first_name + " " + teacher.last_name}
#     #     )}
#     # }
# #    width: "100%",
# #    multiple: true
#     # formatResult: test,
#     # formatSelection: test
# #    }
# #  })
#
#
#
#
# # $ ->
# #   $.fn.editable.defaults.mode = 'inline'
# #
#       # width: "1050px",
#       # url: '/program/get_teachers'
#       # source: ->
#       #   result = undefined
#       #   $.ajax({
#       #     type: "GET",
#       #     url: "/programs/get_teachers",
#       #     dataType: "json",
#       #     success: (response) ->
#       #       alert("Success" + response)
#       #       result = response
#       #   })
#       #   return result
#
#
#       # source: [
#       #   {id: 's2', text: 'Great'}]
#
# # $ ->
# #   $.fn.editable.defaults.mode = 'inline'
# #   $('.all-teachers').each((ind, val) ->
# #     $(val).select2({
# #       width: "1050px",
# #       url: '/program/get_teachers'
# #     }))
#
#   # $('#regular-total').editable({
#   #   url: '/post',
#   #   title: 'Enter User Name'
#   # })
#
#   # $('#group-total').editable({
#   #   url: '/post',
#   #   title: 'Enter User Name'
#   # })
#
#   # $('.all-instruments').each((ind, val) ->
#   #   $(val).editable(prepend: true, children: [{ind, val}]))
# $(document).ready attachHandler
# $(document).on "page:load", attachHandler
