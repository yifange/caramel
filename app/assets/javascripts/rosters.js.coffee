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
addStudentHandler = ->
  $(".menu-item-add-student").on "click", (e) ->
    e.preventDefault()
    href = $(this).attr("href")
    $.get(href, (data, status) ->
      $("#add-student-modal-body").html($(data).filter("#roster-add-student-form-body").html())
      $("#add-student-modal").modal({
        keyboard: true
      })
    )
updateClassHandler = ->
  $(".menu-item-update-class").on "click", (e) ->
    e.preventDefault()
    href = $(this).attr("href")
    $.get(href, (data, status) ->
      $("#update-class-modal-body").html($(data).filter("#course-form-body").html())
      $("#update-class-modal").modal({
        keyboard: true
      })
    )

addStudentModalSubmitHandler = ->
  $("#add-student-modal-confirm").on "click", ->
    $form = $("form.roster")
    $.ajax({
      type: $form.attr("method")
      url: $form.attr("action")
      data: $form.serialize()
      success: (data, status) ->
        $("#add-student-modal").modal("toggle")
        $.get(document.URL, (data, status) ->
          $(".rosters-container").html($(data).find(".rosters-container").html())
          $(".classes-container").html($(data).find(".classes-container").html())
          addStudentHandler()
          newRosterHandler()
          initRosterEditable()
          updateClassHandler()
        )
      error: (data, status) ->
        $("#add-student-modal-body").html($(data.responseText).find("#roster-add-student-form-body").html())
    })
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
          $(".classes-container").html($(data).find(".classes-container").html())
          addStudentHandler()
          newRosterHandler()
          initRosterEditable()
          updateClassHandler()
        )
      error: (data, status) ->
        $("#roster-modal-body").html($(data.responseText).find("#roster-form-body").html())
    })
    return false

updateClassModalSubmitHandler = ->
  $("#update-class-modal-confirm").on "click", ->
    $form = $("form.course")
    $.ajax({
      type: $form.attr("method")
      url: $form.attr("action")
      data: $form.serialize()
      success: (data, status) ->
        $("#update-class-modal").modal("toggle")
        $.get(document.URL, (data, status) ->
          $(".rosters.container").html($(data).find(".rosters-container").html())
          $(".classes-container").html($(data).find(".classes-container").html())
          addStudentHandler()
          newRosterHandler()
          initRosterEditable()
          updateClassHandler()
        )
      error: (data, status) ->
        $("#update-class-modal-body").html($(data.responseText).find("#course-form-body").html())
    })

$(document).ready newRosterHandler
$(document).ready rosterModalSubmitHandler
$(document).ready initRosterEditable
$(document).ready addStudentHandler
$(document).ready addStudentModalSubmitHandler
$(document).ready updateClassHandler
$(document).ready updateClassModalSubmitHandler

$(document).on "page:load", newRosterHandler
$(document).on "page:load", rosterModalSubmitHandler
$(document).on "page:load", initRosterEditable
$(document).on "page:load", addStudentHandler
$(document).on "page:load", addStudentModalSubmitHandler
$(document).on "page:load", updateClassHandler
$(document).on "page:load", updateClassModalSubmitHandler
