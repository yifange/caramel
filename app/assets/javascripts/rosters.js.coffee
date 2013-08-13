newRosterHandler = ->
  $(".new-roster").on "click", (e) ->
    e.preventDefault()
    href = $(this).attr("href")
    $.get(href, (data, status) ->
      $("#roster-modal-body").html($(data).filter("#roster-form-body").html())
      $("#roster-modal").modal({
        keyboard: true
      })
    )


$(document).ready newRosterHandler
$(document).on "page:load", newRosterHandler
