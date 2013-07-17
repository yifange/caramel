# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
attachColumnHandler = ->
  $("div.wc-day-column-inner").css("cursor", "pointer").on "click", ->
    date = $(this).data("date")
    # window.location.href = "/events/new?date=" + date
    $.get("/events/new?date=" + date, (data, status) ->
      $("#event-modal-body").html($(data).filter("#event-form-body").html())
      $("#event-new-submit").hide()
      $("#event-modal-delete").hide()
      $("#event-modal-title").html("Create Event")
      $("#event-modal").modal({
        keyboard: true
      })

    )
    return false

attachEventHandler = ->
  $("div.wc-cal-event").on "click", ->
    eventId = $(this).data("eventid")
    # window.location.href = "/events/" + eventId + "/edit"
    $.data($("#event-modal-delete")[0], "eventid", eventId)
    $.get("/events/" + eventId + "/edit", (data, status) ->
      $("#event-modal-body").html($(data).filter("#event-form-body").html())
      $("#event-new-submit").hide()
      $("#event-modal-delete").show()
      $("#event-modal-title").html("Update Event")
      $("#event-modal").modal({
        keyboard: true
      })
    )
    return false

attachSubmitHandler = ->
  $("#event-modal-confirm").on "click", ->
    $form = $("form.event")
    # alert($form.attr("method"))
    $.ajax({
      type: $form.attr("method"),
      url: $form.attr("action"),
      data: $form.serialize(),
      success: (data, status) ->
        $("#event-modal").modal("toggle")
        $.get(document.URL, (data, status) ->
          $(".wc-container").html($(data).filter(".wc-container").html())
          attachColumnHandler()
          attachEventHandler()
        )
    })
attachDeleteHandler = ->
  $("#event-modal-delete").on "click", ->
    eventId = $(this).data("eventid")
    $.ajax({
      type: "POST",
      url: "/events/" + eventId,
      data: {"_method": "delete"},
      complete: (data, status) ->
        $("#event-modal").modal("toggle")
        $.get(document.URL, (data, status) ->
          $(".wc-container").html($(data).filter(".wc-container").html())
          attachColumnHandler()
          attachEventHandler()
        )
    })

$(document).ready attachColumnHandler
$(document).ready attachEventHandler
$(document).ready attachSubmitHandler
$(document).ready attachDeleteHandler

$(document).on "page:load", attachColumnHandler
$(document).on "page:load", attachEventHandler
$(document).on "page:load", attachSubmitHandler
$(document).on "page:load", attachDeleteHandler
