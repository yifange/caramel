# attachResetPwdHandler = ->
#   $('.reset-pwd').on "click", ->
#     toBeReset = "input[type=checkbox]:checked"
#     $( toBeReset ).each(i, val) ->
#     $.ajax(
#       type: "POST"
#       url:
#     )

initXEditable = ->
  # user_name
  $('.x-editable-input-user-name').editable({
    ajaxOptions: {
      type: 'PUT'
    }
    name: 'user_name'
    type: 'user_name'
  })

  # number
  $('.x-editable-input-number').editable({
    ajaxOptions: {
      type: 'PUT'
    }
    name: 'number'
    type: 'number'
  })

  # text
  $('.x-editable-input-text').editable({
    ajaxOptions: {
      type: 'PUT'
    }
    type: 'text'
  })

  # $(".x-editable.roster-date").editable({
  #   type: "date"
  #   onblur: "submit"
  #   showbuttons: false
  #   ajaxOptions: {
  #     type: "PUT"
  #   }
  # })

  # $(".x-editable.roster-notes").editable({
  #   type: "textarea"
  #   onblur: "submit"
  #   placeholder: "notes, ctrl-enter to submit"
  #   showbuttons: false
  #   inputclass: "input-small"
  #   rows: 2
  #   ajaxOptions: {
  #     type: "PUT"
  #   }
  # })

  $('.x-editable-password').editable({
    type: "password"
  })

initDeleteEntry = ->
  $('.delete-entry').on "click", (e)->
    deleteList = []
    toBeDelete = "input[type=checkbox]:checked"
    $( toBeDelete ).each((i, val) ->
      deleteList.push($(this).val())
    )
    $.ajax(
      type: "POST",
      data: {"deleteList": deleteList},
      url: $(this).data("url"),
      success: (data, status) ->
        $(".flash-message").html($(data).find(".flash-message").html())

        cur_pane_id = $(".active .school-pane.tab-pane.active").attr("id")

        # Current tab-pane is undefined except on Program page.
        if cur_pane_id != undefined
          $(".active .school-pane.tab-pane.active").html($(data).find("#" + cur_pane_id).html())
          initAllSelection(".active .school-pane.tab-pane.active")
        else
          $(".table").html($(data).find(".table").html())
          initAllSelection('')

        initXEditable()
    )

initSubmit = ->
  $(".new-entry-modal-confirm").on "click", ->
    $form = $("form.new_entry")
    $.ajax({
      type: $form.attr("method"),
      url: $form.attr("action"),
      data: $form.serialize(),
      success: (data, status) ->
        $(".flash-message").html($(data).find(".flash-message").html())

        $(".new-entry-modal").modal("toggle")
        cur_pane_id = $(".active .school-pane.tab-pane.active").attr("id")

        # Current tab-pane is undefined except on Program page.
        if cur_pane_id != undefined
          $(".active .school-pane.tab-pane.active").html($(data).find("#" + cur_pane_id).html())
          initAllSelection(".active .school-pane.tab-pane.active")
        else
          $(".table").html($(data).find(".table").html())
          initAllSelection('')

        initXEditable()

      error: (data, status) ->
        $(".error-message").html($(data.responseText).find(".error-message").html())
    })

initProfile = ->
  $(".profile").on "click", (e) ->
    e.preventDefault()
    $.get($(this).attr("href"), (data, status) ->
      $(".profile-modal-body").html($(data).find(".profile-form-body").html())
      $(".profile-modal").modal({
        keyboard: true
      })
    )

initProfileSubmit = ->
  $(".profile-modal-confirm").on "click", ->
    form = $("form.profile")
    $.ajax({
      type: form.attr("method"),
      url: form.attr("action"),
      data: form.serialize(),
      success: (data, status) ->
        r = form.serializeArray()
        $(".profile-modal").modal("toggle")
        $("#current_user_name").html(r[3].value + " " + r[4].value)
        $(".flash-message").html($(data).find(".flash-message").html())
      error: (data, status) ->
        $(".error-message").html('not same with password.')
      })

initNewEntry = ->
  $(".new-entry").on "click", (e) ->
    identity = $(this).data("entry")
    e.preventDefault()
    href = $(this).attr("href")
    $.get(href + "?entry_identity=" + identity, (data, status) ->
      $(".new-entry-modal-body").html($(data).find(".new-entry-form-body").html())
      $(".new-entry-modal").modal({
        keyboard: true
      })
    )

  $(".new-program-entry").on "click", (e) ->
    identity = $(this).data("entry")
    e.preventDefault()
    href = $(this).attr("href")
    cur_pane_id = $(".active .school-pane.tab-pane.active").attr("id").replace("tab-school", "")
    $.get(href + "?school_id=" + cur_pane_id, (data, status) ->
      $(".new-entry-modal-body").html($(data).find(".new-entry-form-body").html())
      $(".new-entry-modal").modal({
        keyboard: true
      })
    )

attachTagClickHandler = ->
  clickHandlerA = ->
    $(".select2-search-choice").unbind("click")
    $(".select2-search-choice").bind("click", clickHandlerA)
    $( ->
      $(".select2-search-choice").popover()
    )
  $(".select2-search-choice").bind("click", clickHandlerA)

attachTooltipHandler = ->
  $("a.tab-hover").tooltip({
    placement: "bottom"
  })

teacherRegionsRefresh = (id, data) ->
  $("#collapse" + id + '-').html($(data).find("#collapse" + id + '-').html())
  initSelection(teacherProgramsRefresh, '#collapse' + id + '-', 'teacher-programs')

teacherProgramsRefresh = (id, data) ->
  $(".teacher-regions-" + id + '-').parent().html($(data).find(".teacher-regions-" + id + '-').parent().html())
  initSelection(teacherRegionsRefresh, '', 'teacher-regions-' + id + '-')

studentProgramsRefresh = (id, data) ->
  $(".student-school-" + id + '-').parent().html($(data).find(".student-school-" + id + '-').parent().html())
  initSelection(studentSchoolRefresh , '', 'student-school-' + id + '-')

studentSchoolRefresh = (id, data) ->
  $(".student-programs-" + id + '-').parent().html($(data).find(".student-programs-" + id + '-').parent().html())
  initSelection(studentProgramsRefresh , '', 'student-programs-' + id + '-')

initSelection = (refresh, parent, selector) ->
  $.fn.editable.defaults.mode = 'inline'

  $(parent + " [class*="+selector+"]").select2({
    width: '100%'
  })

  $(parent + " [class*="+selector+"]").on("change", (e) ->
    data = {pk: $(this).data("pk"), name: $(this).data("name")}
    if e.added && e.removed
      data["option"] = 'change'
      data["value_remove"] = e.removed.id
      data["value_add"] = e.added.id
    else if e.added
      data["option"] = "add"
      data["value"] = e.added.id
    else
      data["option"] = "remove"
      data["value"] = e.removed.id
    $.ajax({
      type: "PUT"
      url: $(this).data("value")
      data: data
      dataType: "json"
      success: (data, status) ->
        id = data.id
        $.get(document.URL, (data, status) ->
          refresh(id, data)
        )
    })
  )

initAllSelection = (parent)->
  initSelection(teacherRegionsRefresh, parent, 'teacher-regions')
  initSelection(teacherProgramsRefresh, parent, 'teacher-programs')
  initSelection(studentSchoolRefresh, parent, 'student-school')
  initSelection(studentProgramsRefresh, parent, 'student-programs')
  initSelection('', parent, 'staff-regions')
  initSelection('', parent, 'school-region')
  initSelection('', parent, 'program-teachers')
  initSelection('', parent, 'program-students')
  initSelection('', parent, 'program-instrument')
  initSelection('', parent, 'program-type')

initNewAndDelete = ->
  initNewEntry()
  initSubmit()
  initDeleteEntry()

$(document).ready( ->
  initAllSelection('')
  initXEditable()
  initNewAndDelete()
  initProfile()
  initProfileSubmit()
  attachTagClickHandler()
  attachTooltipHandler()
)

$(document).on("page:load", ->
  initAllSelection('')
  initXEditable()
  initNewAndDelete()
  initProfile()
  initProfileSubmit()
  attachTagClickHandler()
  attachTooltipHandler()
)
