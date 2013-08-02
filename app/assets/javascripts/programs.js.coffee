# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $.fn.editable.defaults.mode = 'inline'
  $('.instrument-options').editable({
    showbuttons: false
  })

  $(".teacher-options").on("select2-blur", ->
    $.ajax(
      type: "POST",
      url: "/programs/save_teachers",
      data: {value: $(this).val(), pk: $(this).data("pk")},
      dataType: "json", results: (data, page) ->
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
    }
    initSelection: (element, callback) ->
      data = []
      $(element.val().split(",")).each( ->
        item = this.split(":")
        data.push({
          id: item[0], text: item[1]
        })
      )
      element.val('')
      callback(data)
    width: '100%',
    multiple: true
  })

 # $ ('#school-tabs a').click((e) ->
 #   e.preventDefault()
 #   $(this).tab('show')
 #   )
