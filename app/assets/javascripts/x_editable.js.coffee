attachHandler = ->
  $.fn.editable.defaults.mode = 'inline'

  $('.x-editable-select2-multiple').editable({
    ajaxOptions: {
      type: 'PUT'
    }
    select2: {
      multiple: true
      # id: (item) ->
        # return item.CountryId
      ajax: {
        url: '/regions'
        data: (term, page) ->
          return { query: term }
        results: (data, page) ->
          return { results: data }
      }
      initSelection: (element, callback) ->
        if element.val().split(",")[0] == 'url'
          window.url = element.val().split(",")[1]
        element.val('')
        return $.get(window.url,
          (data) ->
            callback(data))
    }
    showbuttons: false
    type: 'select2'
  })

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
