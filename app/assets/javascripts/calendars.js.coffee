attachDayGridHandler = ->
  $("td.day-text").on "click", ->
    year = $(this).data("year")
    month = $(this).data("month")
    day = $(this).data("day")
    window.location.href = "/calendars/week?year=" + year + "&month=" + month + "&day=" + day

attachColumnHandler = ->
  $("div.wc-day-column-inner.calendar-cal.editable").css("cursor", "pointer").on "click", ->
    date = $(this).data("date")
    # window.location.href = "/events/new?date=" + date
    $.get("/calendars/new?date=" + date + "&school_id=" + $(".wc-container").data("school"), (data, status) ->
      $("#calendar-modal-body").html($(data).filter("#calendar-form-body").html())
      $("#calendar-form-submit").hide()
      $("#calendar-modal-delete").hide()
      $("#calendar-modal-title").html("Create Event")
      $("#calendar-modal").modal({
        keyboard: true
      })
    )
    return false

attachEventHandler = ->
  $("div.wc-cal-event.calendar-cal.editable").on "click", ->
    eventId = $(this).data("eventid")
    $.data($("#calendar-modal-delete")[0], "eventid", eventId)
    $.get("/calendars/" + eventId + "/edit", (data, status) ->
      $("#calendar-modal-body").html($(data).filter("#calendar-form-body").html())
      $("#calendar-form-submit").hide()
      $("#calendar-modal-delete").show()
      $("#calendar-modal-title").html("Update Event")
      $("#calendar-modal").modal({
        keyboard: true
      })
      # initTimepicker()
      # initDatepicker()
    )
    return false

attachSubmitHandler = ->
  $("#calendar-modal-confirm").on "click", ->
    $form = $("form.calendar")
    $.ajax({
      type: $form.attr("method"),
      url: $form.attr("action"),
      data: $form.serialize(),
      success: (data, status) ->
        $("#calendar-modal").modal("toggle")
        $.get(document.URL, (data, status) ->
          $(".wc-container").html($(data).find(".wc-container").html())
          attachColumnHandler()
          attachEventHandler()
        )
      error: (data, status) ->
        $("#calendar-modal-body").html($(data.responseText).filter("#calendar-form-body").html())
    })
# XXX Choose the right event to delete? What if the user chooses a different event in the form??
attachDeleteHandler = ->
  $("#calendar-modal-delete").on "click", ->
    eventId = $(this).data("eventid")
    recurring = $("input#calendar_recurring").is(":checked")
    $.ajax({
      type: "POST",
      url: "/calendars/" + eventId,
      data: {"_method": "delete", "recurring": recurring},
      complete: (data, status) ->
        $("#calendar-modal").modal("toggle")
        $.get(document.URL, (data, status) ->
          $(".wc-container").html($(data).find(".wc-container").html())
          attachColumnHandler()
          attachEventHandler()
        )
    })

attachSubnavHandler = ->
  $subnavPrev = $("#subnav-prev")
  $subnavNext = $("#subnav-next")
  $subnavText = $("#subnav-text")
  $subnavToday = $("#subnav-today")
  # $subnavSchoolName = $("#subnav-school-name")
  # $subnavSchoolId = $("#subnav-school-id")
  # $subnavProgramName = $("#subnav-program-name")
  # $subnavProgramId = $("#subnav-program-id")

  $nextLink = $("#cal-nav-next").attr("href")
  $prevLink = $("#cal-nav-prev").attr("href")
  $todayLink = $("#cal-nav-today").attr("href")
  # $school_id = $("#cal-nav-school-id").text()
  # $school_name = $("#cal-nav-school-name").text()
  # $program_id = $("#cal-nav-program-id").text()
  # $program_name = $("#cal-nav-program-name").text()
  $title = $("#cal-nav-title").html()

  $subnavPrev.attr("href", $prevLink)
  $subnavNext.attr("href", $nextLink)
  $subnavToday.attr("href", $todayLink)
  $subnavText.html($title)
  # $subnavSchoolName.html($school_name)
  # $subnavSchoolId.html($school_id)
  # $subnavProgramName.html($program_name)
  # $subnavProgramId.html($program_id)



attachRadioHandler = ->
  $("div.btn-group[data-toggle-name=*]").each ->
    group = $(this)
    form = group.parents('form').eq(0)
    name = group.attr('data-toggle-name')
    hidden = $('input[name="' + name + '"]', form)
    $('button', group).each ->
      button = $(this)
      button.on "click", ->
        hidden.val($(this).val())
      if button.val() == hidden.val()
        button.addClass('active')



$(document).ready attachColumnHandler
$(document).ready attachEventHandler
$(document).ready attachSubmitHandler
$(document).ready attachDeleteHandler
# $(document).ready attachSubnavHandler
$(document).on "page:load", attachColumnHandler
$(document).on "page:load", attachEventHandler
$(document).on "page:load", attachSubmitHandler
$(document).on "page:load", attachDeleteHandler
# $(document).on "page:load", attachSubnavHandler
