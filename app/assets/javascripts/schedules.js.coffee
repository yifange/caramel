newClassNameInput = ->
  $("label[for='schedule_name']").append(" (<a id='schedule-name-select' href='#'>select</a>)")
  $("label[for='schedule_course_id']").append(" (<a id='schedule-name-new' href='#'>new</a>)")
  $("a#schedule-name-select").on "click", (e) ->
    e.preventDefault()
    $("#schedule-course-name").hide()
    $("#schedule-course-type").hide()
    $("#schedule-course-select").show()
    $("#schedule_name").val("")

  $("a#schedule-name-new").on "click", (e) ->
    e.preventDefault()
    $("#schedule-course-select").hide()
    $("#schedule-course-name").show()
    $("#schedule-course-type").show()

  $("#schedule-course-name").hide()

attachScheduleColumnHandler = ->
  $("div.wc-day-column-inner.schedule-cal").css("cursor", "pointer").on "click", ->
    date = $(this).data("date")
    # window.location.href = "/events/new?date=" + date
    $.get("/schedules/new?date=" + date + "&program_id=" + $(".wc-container").data("program"), (data, status) ->
      $("#schedule-modal-body").html($(data).filter("#schedule-form-body").html())
      newClassNameInput()
      $("#schedule-form-submit").hide()
      $("#schedule-modal-delete").hide()
      $("#schedule-recurring-selection").hide()
      $("#schedule-course-type").hide()
      $("#schedule-course-name").hide()
      $("#schedule-modal-title").html("Create Class")
      $("#schedule-modal").modal({
        keyboard: true
      })
    )
    return false

attachScheduleEventHandler = ->
  $("div.wc-cal-event.schedule-cal").on "click", ->
    eventId = $(this).data("eventid")
    $.data($("#schedule-modal-delete")[0], "eventid", eventId)
    $.get("/schedules/" + eventId + "/edit", (data, status) ->
      $("#schedule-modal-body").html($(data).filter("#schedule-form-body").html())
      $("#schedule-form-submit").hide()
      $("#schedule-course-name").hide()
      $("#schedule-course-type").hide()
      $("#schedule-modal-delete").show()
      $("#schedule-modal-title").html("Update Class")
      $("#schedule-modal").modal({
        keyboard: true
      })
    )
    return false

attachScheduleSubmitHandler = ->
  $("#schedule-modal-confirm").on "click", ->
    $form = $("form.schedule")
    $.ajax({
      type: $form.attr("method"),
      url: $form.attr("action"),
      data: $form.serialize(),
      success: (data, status) ->
        $("#schedule-modal").modal("toggle")
        $.get(document.URL, (data, status) ->
          $(".wc-container").html($(data).find(".wc-container").html())
          attachScheduleColumnHandler()
          attachScheduleEventHandler()
        )
      error: (data, status) ->

        $("#schedule-modal-body").html($(data.responseText).filter("#schedule-form-body").html())
    })
    return false

attachScheduleDeleteHandler = ->
  $("#schedule-modal-delete").on "click", ->
    eventId = $(this).data("eventid")
    recurring = $("select#schedule_recurring").val()
    $.ajax({
      type: "POST",
      url: "/schedules/" + eventId,
      data: {"_method": "delete", "recurring": recurring},
      complete: (data, status) ->
        $("#schedule-modal").modal("toggle")
        $.get(document.URL, (data, status) ->
          $(".wc-container").html($(data).find(".wc-container").html())
          attachScheduleColumnHandler()
          attachScheduleEventHandler()
        )
    })


$(document).ready attachScheduleColumnHandler
$(document).ready attachScheduleEventHandler
$(document).ready attachScheduleSubmitHandler
$(document).ready attachScheduleDeleteHandler
$(document).ready newClassNameInput
$(document).on "page:load", attachScheduleColumnHandler
$(document).on "page:load", attachScheduleEventHandler
$(document).on "page:load", attachScheduleSubmitHandler
$(document).on "page:load", attachScheduleDeleteHandler
$(document).on "page:load", newClassNameInput

