# attachResetPwdHandler = ->
#   $('.reset-pwd').on "click", ->
#     toBeReset = "input[type=checkbox]:checked"
#     $( toBeReset ).each(i, val) ->
#     $.ajax(
#       type: "POST"
#       url:
#     )

attachDeleteEntryHandler = ->
  $('.delete-entry').on "click", (e)->
    deleteList = []
    toBeDelete = "input[type=checkbox]:checked"
    $( toBeDelete ).each((i, val) ->
      deleteList.push($(this).val())
    )
    $.ajax(
      type: "POST",
      # data: {"_method": "delete"},
      # url: $(this).data("url"),
      # url: "/programs/" + $(this).val(),
      data: {"deleteList": deleteList},
      url: $(this).data("url"),
      success: (data, status) ->
        cur_pane_id = $(".tab-pane.active").attr("id")

        # Current tab-pane is undefined except on Program page.
        if cur_pane_id != undefined
          $(".tab-pane.active").html($(data).find("#" + cur_pane_id).html())
        else
          $(".table").html($(data).find(".table").html())

        attachBlockHandler()
        attachNewEntryHandler()
        attachTagClickHandler()
    )

attachNewEntryHandler = ->
  $(".new-entry").on "click", (e) ->
    identity = $(this).data("entry")
    e.preventDefault()
    href = $(this).attr("href")
    $.get(href + "?entry_identity=" + identity, (data, status) ->
      $(".new-entry-modal-body").html($(data).find(".new-entry-form-body").html())
      # attachBlockHandler()
      $(".new-entry-modal").modal({
        keyboard: true
      })
    )

  $(".new-program-entry").on "click", (e) ->
    identity = $(this).data("entry")
    e.preventDefault()
    href = $(this).attr("href")
    cur_pane_id = $(".tab-pane.active").attr("id").replace("tab", "")
    $.get(href + "?school_id=" + cur_pane_id, (data, status) ->
      $(".new-entry-modal-body").html($(data).find(".new-entry-form-body").html())
      # attachBlockHandler()
      $(".new-entry-modal").modal({
        keyboard: true
      })
    )

attachSubmitHandler = ->
  $(".new-entry-modal-confirm").on "click", ->
    $form = $("form.new_entry")
    $.ajax({
      type: $form.attr("method"),
      url: $form.attr("action"),
      data: $form.serialize(),
      success: (data, status) ->
        $(".new-entry-modal").modal("toggle")
        cur_pane_id = $(".tab-pane.active").attr("id")

        # Current tab-pane is undefined except on Program page.
        if cur_pane_id != undefined
          $(".tab-pane.active").html($(data).find("#" + cur_pane_id).html())
        else
          $(".table").html($(data).find(".table").html())

        attachNewEntryHandler()
        attachBlockHandler()
        attachTagClickHandler()

      error: (data, status) ->
        $(".new-entry-modal-body").html($(data.responseText).find(".new-entry-form-body").html())
    })

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

attachBlockHandler = ->
  $.fn.editable.defaults.mode = 'inline'

  # singular and multiple selection
  $('.singular-multiple-selection').select2({
    width: '100%'
  })

  $('.singular-multiple-selection').on("change", (e) ->
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
    })
  )

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

  $('.x-editable-password').editable({
    type: "password"
  })

$(document).ready attachBlockHandler
# $(document).ready attachResetPwdHandler
$(document).ready attachDeleteEntryHandler
$(document).ready attachNewEntryHandler
$(document).ready attachSubmitHandler
$(document).ready attachTagClickHandler
$(document).ready attachTooltipHandler
$(document).on "page:load", attachBlockHandler
# $(document).on "page:load", attachResetPwdHandler
$(document).on "page:load", attachDeleteEntryHandler
$(document).on "page:load", attachNewEntryHandler
$(document).on "page:load", attachSubmitHandler
$(document).on "page:load", attachTagClickHandler
$(document).on "page:load", attachTooltipHandler
