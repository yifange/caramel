# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
attachTagClickHandler = ->

  clickHandlerA = ->
    $(".select2-search-choice").unbind("click")
    $(".select2-search-choice").bind("click", clickHandlerA)
    $( ->
      $(".select2-search-choice").popover()
    )

  $(".select2-search-choice").bind("click", clickHandlerA)

  # $(".select2-choices").on "click", ".select2-search-choice", (e) ->
  #   $(".select2-choices").unbind("click")
  #   # e.stopPropagation()
  #   return false

attachHandler = ->
  $.fn.editable.defaults.mode = 'inline'


  $(".instrument-options").editable({
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



  $(".student-options").on("select2-blur", ->
    $.ajax(
      type: "POST",
      url: "/programs_page/save_students",
      data: {value: $(this).val(), pk: $(this).data("pk")},
      dataType: "json", results: (data, page) ->
        return {results: data}
    )
  )

  $(".student-options").select2({
    ajax: {
      type: "GET",
      url: "/programs_page/get_students",
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

  $(".teacher-options").on "change", ->
    attachTagClickHandler()

  $(".student-options").on "change", ->
    attachTagClickHandler()

attachNewProgramHandler = ->
  $(".new-program").on "click", (e) ->
    e.preventDefault()
    href = $(this).attr("href")
    $.get(href + "?school_id=" + $(this).data("school"), (data, status) ->
      $("#new-program-modal-body").html($(data).find("#new-program-form-body").html())
      attachHandler()
      $("#new-program-modal").modal({
        keyboard: true
      })
    )
attachTooltipHandler = ->
  $("a.tab-hover").tooltip({
    placement: "right"
  })
attachSubmitHandler = ->
  $("#new-program-modal-confirm").on "click", ->
    $form = $("form#new_program")
    $.ajax({
      type: $form.attr("method"),
      url: $form.attr("action"),
      data: $form.serialize(),
      success: (data, status) ->
        $("#new-program-modal").modal("toggle")
        cur_pane_id = $(".tab-pane.active").attr("id")
        $(".tab-pane.active").html($(data).find("#" + cur_pane_id).html())
        attachNewProgramHandler()
        attachHandler()
        attachTagClickHandler()

      error: (data, status) ->
        $("#new-program-modal-body").html($(data.responseText).find("#new-program-form-body").html())
    })


$(document).ready attachHandler
$(document).ready attachNewProgramHandler
$(document).ready attachSubmitHandler
$(document).ready attachTooltipHandler
$(document).ready attachTagClickHandler
$(document).on "page:load", attachHandler
$(document).on "page:load", attachNewProgramHandler
$(document).on "page:load", attachSubmitHandler
$(document).on "page:load", attachTooltipHandler
$(document).on "page:load", attachTagClickHandler
