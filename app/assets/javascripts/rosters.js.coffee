initRosterEditable = ->
  $(".x-editable.roster-date").editable({
    type: "date"
    onblur: "submit"
    showbuttons: false
    ajaxOptions: {
      type: "PUT"
    }
  })
  $(".x-editable.roster-notes").editable({
    type: "textarea"
    onblur: "submit"
    placeholder: "notes, ctrl-enter to submit"
    showbuttons: false
    inputclass: "input-small"
    rows: 2
    ajaxOptions: {
      type: "PUT"
    }
  })
initDropdown = ->
  $('.dropdown-toggle').dropdown()

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
rosterModalSubmitHandler = ->
  $("#roster-modal-confirm").on "click", ->
    $form = $("form.roster")
    $.ajax({
      type: $form.attr("method")
      url: $form.attr("action")
      data: $form.serialize()
      success: (data, status) ->
        $("#roster-modal").modal("toggle")
        $.get(document.URL, (data, status) ->
          $(".rosters-container").html($(data).find(".rosters-container").html())
          newRosterHandler()
          initRosterEditable()
        )
      error: (data, status) ->
        $("#roster-modal-body").html($(data.responseText).find("#roster-form-body").html())
    })
    return false


$(document).ready newRosterHandler
$(document).ready rosterModalSubmitHandler
$(document).ready initRosterEditable
# $(document).ready initDropdown

$(document).on "page:load", newRosterHandler
$(document).on "page:load", rosterModalSubmitHandler
$(document).on "page:load", initRosterEditable
# $(document).on "page:load", initDropdown
