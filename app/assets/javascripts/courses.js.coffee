attachCourseColumnHandler = ->
  $("div.wc-day-column-inner.course-cal").css("cursor", "pointer").on "click", ->
    date = $(this).data("date")
    # window.location.href = "/events/new?date=" + date
    $.get("/courses/new?date=" + date + "&program_id=" + $(".wc-container").data("program"), (data, status) ->
      $("#course-modal-body").html($(data).find("#course-form-body").html())
      $("#course-form-submit").hide()
      $("#course-modal-delete").hide()
      $("#course-modal-title").html("Create Course")
      $("#course-modal").modal({
        keyboard: true
      })
    )
    return false

attachCourseEventHandler = ->
  $("div.wc-cal-event.course-cal").on "click", ->
    eventId = $(this).data("eventid")
    $.data($("#course-modal-delete")[0], "eventid", eventId)
    $.get("/courses/" + eventId + "/edit", (data, status) ->
      $("#course-modal-body").html($(data).filter("#course-form-body").html())
      $("#course-form-submit").hide()
      $("#course-modal-delete").show()
      $("#course-modal-title").html("Update Event")
      $("#course-modal").modal({
        keyboard: true
      })
    )
    return false

attachCourseSubmitHandler = ->
  $("#course-modal-confirm").on "click", ->
    $form = $("form.course")
    alert("click submit")
    alert($form.serialize())
    $.ajax({
      type: $form.attr("method"),
      url: $form.attr("action"),
      data: $form.serialize(),
      success: (data, status) ->
        alert("success")
        $("#course-modal").modal("toggle")
        $.get(document.URL, (data, status) ->
          $(".wc-container").html($(data).find(".wc-container").html())
          attachCourseColumnHandler()
          attachCourseEventHandler()
        )
      error: (data, status) ->
        alert("error")
        $("#course-modal-body").html($(data.responseText).find("#course-form-body").html())
    })
    return false

attachCourseDeleteHandler = ->
  $("#course-modal-delete").on "click", ->
    eventId = $(this).data("eventid")
    $.ajax({
      type: "POST",
      url: "/courses/" + eventId,
      data: {"_method": "delete"},
      complete: (data, status) ->
        $("#course-modal").modal("toggle")
        $.get(document.URL, (data, status) ->
          $(".wc-container").html($(data).find(".wc-container").html())
          attachCourseColumnHandler()
          attachCourseEventHandler()
        )
    })


$(document).ready attachCourseColumnHandler
$(document).ready attachCourseEventHandler
$(document).ready attachCourseSubmitHandler
$(document).ready attachCourseDeleteHandler

$(document).on "page:load", attachCourseColumnHandler
$(document).on "page:load", attachCourseEventHandler
$(document).on "page:load", attachCourseSubmitHandler
$(document).on "page:load", attachCourseDeleteHandler

