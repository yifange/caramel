attachSubnavHandler = ->
  $subnavPrev = $("#subnav-prev")
  $subnavNext = $("#subnav-next")
  $subnavText = $("#subnav-text")
  $subnavToday = $("#subnav-today")

  $prevLink = $("#cal-nav-prev").attr("href")
  $nextLink = $("#cal-nav-next").attr("href")
  $todayLink = $("#cal-nav-today").attr("href")
  $title = $("#cal-nav-title").html()

  $subnavPrev.attr("href", $prevLink)
  $subnavNext.attr("href", $nextLink)
  $subnavToday.attr("href", $todayLink)
  $subnavText.html($title)

attachModalXeditableFieldsHandler = ->
  $("#attendance-form-course").editable()
attachAttendanceGridHandler = ->
  $("a.fmc-grid-link").on "click", (e) ->
    e.preventDefault()
    href = $(this).attr("href")
    $.get(href, (data, status) ->
      $("#attendance-modal-body").html($(data).find("#attendance-form-body").html())
      $("#attendance-modal").modal({
        keyboard: true
      })
    )



$(document).ready attachSubnavHandler
$(document).ready attachModalXeditableFieldsHandler
$(document).ready attachAttendanceGridHandler

$(document).on "page:load", attachSubnavHandler
$(document).on "page:load", attachModalXeditableFieldsHandler
$(document).on "page:load", attachAttendanceGridHandler
