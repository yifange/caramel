# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $.fn.editable.defaults.mode = 'inline'
  $('.instrument-options').editable({
    source: [
      {value: 1, text: '+'}
    ]

  })

  $('.teacher-options').select2({
    # select2: {
    # }
    # ajax: {
    #   dataType: 'jsonp',
    #   url: "/programs/get_teachers"
    #   data: test = (data, page) =>
    #     return {results: $.map(data, (teacher, i) =>
    #       return {id: teacher.id, text: teacher.first_name + " " + teacher.last_name}
    #     )}
    # }
    width: "100%"
    # multiple: true,
    # formatResult: test,
    # formatSelection: test
  })




# $ ->
#   $.fn.editable.defaults.mode = 'inline'
#
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

