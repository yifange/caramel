# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
attachDayGridHandler = ->
  $("td.day-text").on "click", ->
    year = $(this).data("year")
    month = $(this).data("month")
    day = $(this).data("day")
    window.location.href = "/calendars/week?year=" + year + "&month=" + month + "&day=" + day
    # $.get("/calendars/week?year=" + year + "&month=" + month + "&day=" + day, (data, status) ->
    #   $("#cal-switch-year").toggleClass("active")
    #   $("#cal-switch-week").toggleClass("active")

    #   $("div.wc-container").html($(data).find("div.wc-container").html())
    #   $("div.ac-container").hide("fade",  -> $("div.wc-container").show("fade"))

    #   attachColumnHandler()
    #   attachEventHandler()
    #   return false
    # )

attachColumnHandler = ->
  $("div.wc-day-column-inner").css("cursor", "pointer").on "click", ->
    date = $(this).data("date")
    # window.location.href = "/events/new?date=" + date
    $.get("/calendars/new?date=" + date, (data, status) ->
      $("#calendar-modal-body").html($(data).find("#calendar-form-body").html())
      $("#calendar-new-submit").hide()
      $("#calendar-modal-delete").hide()
      $("#calendar-modal-title").html("Create Event")
      $("#calendar-modal").modal({
        keyboard: true
      })
    )
    return false

attachEventHandler = ->
  $("div.wc-cal-calendar").on "click", ->
    eventId = $(this).data("eventid")
    $.data($("#calendar-modal-delete")[0], "eventid", eventId)
    $.get("/calendars/" + eventId + "/edit", (data, status) ->
      $("#calendar-modal-body").html($(data).find("#calendar-form-body").html())
      $("#calendar-new-submit").hide()
      $("#calendar-modal-delete").show()
      $("#calendar-modal-title").html("Update Event")
      $("#calendar-modal").modal({
        keyboard: true
      })
    )
    return false

attachSubmitHandler = ->
  $("#calendar-modal-confirm").on "click", ->
    $form = $("form.calendar")
    # alert($form.attr("method"))
    $.ajax({
      type: $form.attr("method"),
      url: $form.attr("action"),
      data: $form.serialize(),
      success: (data, status) ->
        $("#calendar-modal").modal("toggle")
        $.get(document.URL, (data, status) ->
          $(".wc-container").html($(data).filter(".wc-container").html())
          attachColumnHandler()
          attachEventHandler()
        )
    })
attachDeleteHandler = ->
  $("#calendar-modal-delete").on "click", ->
    eventId = $(this).data("eventid")
    $.ajax({
      type: "POST",
      url: "/calendars/" + eventId,
      data: {"_method": "delete"},
      complete: (data, status) ->
        $("#calendar-modal").modal("toggle")
        $.get(document.URL, (data, status) ->
          $(".wc-container").html($(data).filter(".wc-container").html())
          attachColumnHandler()
          attachEventHandler()
        )
    })

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





$(document).ready attachColumnHandler
$(document).ready attachEventHandler
$(document).ready attachSubmitHandler
$(document).ready attachDeleteHandler
$(document).ready attachDayGridHandler
$(document).ready attachSubnavHandler
$(document).on "page:load", attachColumnHandler
$(document).on "page:load", attachEventHandler
$(document).on "page:load", attachSubmitHandler
$(document).on "page:load", attachDeleteHandler
$(document).on "page:load", attachDayGridHandler
$(document).on "page:load", attachSubnavHandler



