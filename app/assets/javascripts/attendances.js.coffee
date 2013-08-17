# attachSubnavHandler = ->
#   $subnavPrev = $("#subnav-prev")
#   $subnavNext = $("#subnav-next")
#   $subnavText = $("#subnav-text")
#   $subnavToday = $("#subnav-today")
#
#   $prevLink = $("#cal-nav-prev").attr("href")
#   $nextLink = $("#cal-nav-next").attr("href")
#   $todayLink = $("#cal-nav-today").attr("href")
#   $title = $("#cal-nav-title").html()
#
#   $subnavPrev.attr("href", $prevLink)
#   $subnavNext.attr("href", $nextLink)
#   $subnavToday.attr("href", $todayLink)
#   $subnavText.html($title)


attachModalXeditableFieldsHandler = ->
  $("#attendance-form-course").editable()

attachAttendanceGridHandler = ->
  $("a.class-day").tooltip()
  $("a.fmc-grid-link").on "click", (e) ->
    e.preventDefault()
    href = $(this).attr("href")
    if $(this).data("attendance-id")
      editing = true
      $.data($("#attendance-modal-delete")[0], "attendance-id", $(this).data("attendance-id"))
    else
      editing = false
    $.get(href, (data, status) ->
      $("#attendance-modal-body").html($(data).filter("#attendance-form-body").html())
      if editing
        $("#attendance-modal-delete").show()
      else
        $("#attendance-modal-delete").hide()

      $("#attendance-modal").modal({
        keyboard: true
      })
    )
    return false

attachSubmitHandler = ->
  $("#attendance-modal-confirm").on "click", ->
    $form = $("form.attendance")
    $.ajax({
      type: $form.attr("method"),
      url: $form.attr("action"),
      data: $form.serialize(),
      success: (data, status) ->
        $("#attendance-modal").modal("toggle")
        $.get(document.URL, (data, status) ->
          $(".fmc-container").html($(data).find(".fmc-container").html())
          attachAttendanceGridHandler()
        )
      error: (data, status) ->
        $("#attendance-modal-body").html($(data.responseText).find("#attendance-form-body").html())
    })
attachDeleteHandler = ->
  $("#attendance-modal-delete").on "click", ->
    attendanceId = $(this).data("attendance-id")
    $.ajax({
      type: "POST",
      url: "/attendances/" + attendanceId,
      data: {"_method": "delete"}
      complete: (data, status) ->
        $("#attendance-modal").modal("toggle")
        $.get(document.URL, (data, status) ->
          $(".fmc-container").html($(data).find(".fmc-container").html())
          attachAttendanceGridHandler()
        )
    })

# $(document).ready attachSubnavHandler
# $(document).ready attachModalXeditableFieldsHandler
$(document).ready attachAttendanceGridHandler
$(document).ready attachSubmitHandler
$(document).ready attachDeleteHandler

# $(document).on "page:load", attachSubnavHandler
# $(document).on "page:load", attachModalXeditableFieldsHandler
$(document).on "page:load", attachAttendanceGridHandler
$(document).on "page:load", attachSubmitHandler
$(document).on "page:load", attachDeleteHandler


# All the pages can share the attachSubmitHandle
