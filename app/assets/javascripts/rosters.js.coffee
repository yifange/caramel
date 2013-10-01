initRosterEditable = ->
  $(".x-editable.roster-date").editable({
    type: "date"
    onblur: "submit"
    showbuttons: false
    ajaxOptions: {
      type: "PUT"
    }
    success: ->
      $.get(document.URL, (data, status) ->
        $(".rosters-container").html($(data).find(".rosters-container").html())
        $(".classes-container").html($(data).find(".classes-container").html())
        addStudentHandler()
        newRosterHandler()
        initRosterEditable()
        updateClassHandler()
        deleteClassHandler()
        studentsSelect()
      )

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
    return false
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
    return false

addClassHandler = ->
  $(".btn.add-class").on "click", (e) ->
    e.preventDefault()
    href = $(this).attr("href")
    $.get(href, (data, status) ->
      $("#add-class-modal-body").html($(data).filter("#course-form-body").html())
      $("#add-class-modal").modal({
        keyboard: true
      })
    )
    return false

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
deleteClassHandler = ->
  $(".menu-item-delete-class").on "click", (e) ->
    e.preventDefault()
    href = $(this).attr("href")
    $.ajax({
      type: "POST"
      url: href
      data: {"_method": "delete"}
      success: (data, status) ->
        $.get(document.URL, (data, status) ->
          $(".rosters-container").html($(data).find(".rosters-container").html())
          $(".classes-container").html($(data).find(".classes-container").html())
          addStudentHandler()
          newRosterHandler()
          addClassHandler()
          initRosterEditable()
          updateClassHandler()
          deleteClassHandler()
          studentsSelect()
        )
    })
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
          addClassHandler()
          initRosterEditable()
          updateClassHandler()
          deleteClassHandler()
          studentsSelect()
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
          newRosterHandler()
          addClassHandler()
          initRosterEditable()
          updateClassHandler()
          deleteClassHandler()
          studentsSelect()
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
          addClassHandler()
          initRosterEditable()
          updateClassHandler()
          deleteClassHandler()
          studentsSelect()
        )
      error: (data, status) ->
        $("#update-class-modal-body").html($(data.responseText).find("#course-form-body").html())
    })

addClassModalSubmitHandler = ->
  $("#add-class-modal-confirm").on "click", ->
    $form = $("form.course")
    $.ajax({
      type: $form.attr("method")
      url: $form.attr("action")
      data: $form.serialize()
      success: (data, status) ->
        $("#add-class-modal").modal("toggle")
        $.get(document.URL, (data, status) ->
          $(".rosters.container").html($(data).find(".rosters-container").html())
          $(".classes-container").html($(data).find(".classes-container").html())
          addStudentHandler()
          newRosterHandler()
          addClassHandler()
          initRosterEditable()
          updateClassHandler()
          deleteClassHandler()
          studentsSelect()
        )
      error: (data, status) ->
        $("#add-class-modal-body").html($(data.responseText).find("#course-form-body").html())
    })
accordionHandler = ->
  $(".accordion-parent").on "click", ".accordion-toggle", ->
    target = $(this).data("target")
    $(".accordion-body#" + target).toggle(50)

studentsSelect = ->
  $(".roster-class-students").select2({
    width: "100%"
    formatSelection: (item, container) ->
      container.attr("class", $(item.element).attr("class"))
      container.append(item.text)
      return
  }).on "change", (e) ->
    courseId = $(this).parent().data("courseid")
    if (e.added)
      enrollmentId = e.added.id
      $.post("/rosters", {roster: {course_id: courseId, enrollment_id: enrollmentId}}, ->
        $.get(document.URL, (data, status) ->
          $(".rosters-container").html($(data).find(".rosters-container").html())
          newRosterHandler()
          initRosterEditable()
        )
      )
    else if (e.removed)
      enrollmentId = e.removed.id
      $.post("/rosters/remove", {_method: "DELETE", course_id: courseId, enrollment_id: enrollmentId}, ->
        $.get(document.URL, (data, status) ->
          $(".rosters-container").html($(data).find(".rosters-container").html())
          newRosterHandler()
          initRosterEditable()
        )
      )

$(document).ready newRosterHandler
$(document).ready rosterModalSubmitHandler
$(document).ready initRosterEditable
$(document).ready addStudentHandler
$(document).ready addStudentModalSubmitHandler
$(document).ready updateClassHandler
$(document).ready deleteClassHandler
$(document).ready updateClassModalSubmitHandler
$(document).ready addClassHandler
$(document).ready addClassModalSubmitHandler
$(document).ready accordionHandler
$(document).ready studentsSelect

$(document).on "page:load", newRosterHandler
$(document).on "page:load", rosterModalSubmitHandler
$(document).on "page:load", initRosterEditable
$(document).on "page:load", addStudentHandler
$(document).on "page:load", addStudentModalSubmitHandler
$(document).on "page:load", updateClassHandler
$(document).on "page:load", deleteClassHandler
$(document).on "page:load", updateClassModalSubmitHandler
$(document).on "page:load", addClassHandler
$(document).on "page:load", addClassModalSubmitHandler
$(document).on "page:load", accordionHandler
$(document).on "page:load", studentsSelect
