# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

attachHandler = ->
  $.fn.editable.defaults.mode = 'inline'
  $('.instrument-options').editable({
    showbuttons: false
  })

  $('.course-type-options').editable({
    showbuttons: false
  })

  $('.regular-courses-per-year').editable({
    showbuttons: false
  })

  $('.group-courses-per-year').editable({
    showbuttons: false
  })

  $(".teacher-options").on("select2-blur", ->
    $.ajax(
      type: "POST",
      url: "/programs_page/save_teachers",
      data: {value: $(this).val(), pk: $(this).data("pk")},
      dataType: "json", results: (data, page) ->
        return {results: data}
    )
  )

  $(".teacher-options").select2({
    ajax: {
      type: "GET",
      url: "/programs_page/get_teachers",
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

attachNewProgramHandler = ->
  $(".new-program").on "click", (e) ->
    e.preventDefault()
    href = $(this).attr("href")
    $.get(href, (data, status) ->
      $("#new-program-modal-body").html($(data).find("#new-program-form-body").html())
      $("#new-program-modal").modal({
        keyboard: true
      })
    )
    return false

attachSubmitHandler = ->
  $("#new-program-modal-confirm").on "click", ->
    $form = $("form.new-program")
    $.ajax({
      type: $form.attr("method"),
      url: $form.attr("action"),
      data: $form.serialize(),
      success: (data, status) ->
        $("#new-program-modal").modal("toggle")
        $.get(document.URL, (data, status) ->
          $(".fmc-container").html($(data).find(".fmc-container").html())
          attachAttendanceGridHandler()
        )
      error: (data, status) ->
        $("#new-program-modal-body").html($(data.responseText).find("#new-program-form-body").html())
    })


$(document).ready attachHandler
$(document).ready attachNewProgramHandler
$(document).ready attachSubmitHandler
$(document).on "page:load", attachHandler
$(document).on "page:load", attachNewProgramHandler
$(document).on "page:load", attachSubmitHandler
