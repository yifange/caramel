attachDayGridHandler = ->
  $("td.day-text").on "click", ->
    year = $(this).data("year")
    month = $(this).data("month")
    day = $(this).data("day")
    window.location.href = "/calendars/week?year=" + year + "&month=" + month + "&day=" + day

attachColumnHandler = ->
  $("div.wc-day-column-inner.calendar-cal").css("cursor", "pointer").on "click", ->
    date = $(this).data("date")
    # window.location.href = "/events/new?date=" + date
    $.get("/calendars/new?date=" + date, (data, status) ->
      $("#calendar-modal-body").html($(data).find("#calendar-form-body").html())
      $("#calendar-form-submit").hide()
      $("#calendar-modal-delete").hide()
      $("#calendar-modal-title").html("Create Event")
      $("#calendar-modal").modal({
        keyboard: true
      })
    )
    return false

attachEventHandler = ->
  $("div.wc-cal-event.calendar-cal").on "click", ->
    eventId = $(this).data("eventid")
    $.data($("#calendar-modal-delete")[0], "eventid", eventId)
    $.get("/calendars/" + eventId + "/edit", (data, status) ->
      $("#calendar-modal-body").html($(data).find("#calendar-form-body").html())
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
        $("#calendar-modal-body").html($(data.responseText).find("#calendar-form-body").html())
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

  $prevLink = $("#cal-nav-prev").attr("href")
  $nextLink = $("#cal-nav-next").attr("href")
  $todayLink = $("#cal-nav-today").attr("href")
  $title = $("#cal-nav-title").html()

  $subnavPrev.attr("href", $prevLink)
  $subnavNext.attr("href", $nextLink)
  $subnavToday.attr("href", $todayLink)
  $subnavText.html($title)



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




# initTimepicker = ->
#   $("#calendar_start_time").timepicker({
#   })
#   $("#calendar_end_time").timepicker({
#   })
# initDatepicker = ->
#   $("#calendar_date").datepicker()
# initSelectpicker = ->
#   $(".selectpicker").selectpicker()

$(document).ready attachColumnHandler
$(document).ready attachEventHandler
$(document).ready attachSubmitHandler
$(document).ready attachDeleteHandler
$(document).ready attachSubnavHandler
$(document).on "page:load", attachColumnHandler
$(document).on "page:load", attachEventHandler
$(document).on "page:load", attachSubmitHandler
$(document).on "page:load", attachDeleteHandler
$(document).on "page:load", attachSubnavHandler
