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


$(document).ready attachSubnavHandler
$(document).ready attachModalXeditableFieldsHandler

$(document).on "page:load", attachSubnavHandler
$(document).on "page:load", attachModalXeditableFieldsHandler
