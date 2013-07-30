# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $.fn.editable.defaults.mode = 'inline'
  $('.instrument-options').editable({
  })

  $(".teacher-options").on("select2-blur", ->
    $.ajax(
      type: "POST",
      url: "/programs/save_teachers",
      data: {value: $(this).val(), pk: $(this).data("pk")},
      dataType: "json",
      results: (data, page) ->
        return {results: data}
    )
  )

  $(".teacher-options").select2({
    ajax: {
      type: "GET",
      url: "/programs/get_teachers",
      dataType: "json",
      results: (data, page) ->
        return {results: data}
    },
    initSelection: (element, callback) ->
      data = []
      $(element.val()).split(",").each( ->
        item = this.split(";")
        data.push({
          id: item[0],
          text: item[1]
        })
      )
      element.val('')
      callback(data)
    width: '100%',
    multiple: true
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

