attachHandler = ->
  $.fn.editable.defaults.mode = 'inline'

  $('.select2-multiple').select2()

  $(".select2-multiple").on("change", (e) ->
    data = {pk: $(this).data("pk"), name: $(this).data("name")}
    if e.added
      data["option"] = "add"
      data["value"] = e.added.id
    else
      data["option"] = "remove"
      data["value"] = e.removed.id
    $.ajax(
      type: "PUT",
      url: $(this).data("value")
      data: data
      dataType: "json", results: (data, page) ->
        return {results: data}
    )
  )

  # select2 singular
  $('.x-editable-select2-singular').editable({
    ajaxOptions: {
      type: 'PUT'
    }
    showbuttons: false
    type: 'select2'
  })

  # user_name
  $('.x-editable-input-user-name').editable({
    ajaxOptions: {
      type: 'PUT'
    }
    name: 'user_name'
    type: 'user_name'
  })

  # user_name
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

  $('.x-editable-input-text').editable({
    ajaxOptions: {
      type: 'PUT'
      dataType: 'json'
    }
    type: 'text'
  })

$(document).ready attachHandler
$(document).on "page:load", attachHandler
