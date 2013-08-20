attachHandler = ->
  $.fn.editable.defaults.mode = 'inline'

  $('.select2').select2({
    width: '100%'
  })

  $(".select2").on("change", (e) ->
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
    $.ajax(
      type: "PUT"
      url: $(this).data("value")
      data: data
      dataType: "json", results: (data, page) ->
        return {results: data}
    )
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

$(document).ready attachHandler
$(document).on "page:load", attachHandler
