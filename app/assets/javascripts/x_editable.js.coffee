attachHandler = ->
  $.fn.editable.defaults.mode = 'inline'

  # select2 multiple
  # $('.x-editable-select2-multiple').select2({
  #   data:[{id:0,text:'GWU'},{id:1,text:'JHU'},{id:2,text:'SJU'},{id:3,text:'ddd'}]
  #   multiple: true
  #   placeholder: 'select schools'
  # })

  $('.x-editable-select2-multiple').editable({
    select2: {
      multiple: true
      # id: (item) ->
      #   return item.CountryId
      # ajax: {
      #   url: '/getCountries'
      #   dataType: 'json'
      #   data: (term, page) ->
      #     return { query: term }
      #   results: (data, page) ->
      #     return { results: data }
      # }
      # formatResult: (item) ->
      #   return item.CountryName
      # formatSelection: (item) ->
      #   return item.CountryName
      # initSelection: (element, callback) ->
      #   return $.get('/getCountryById', { query: element.val() },
      #   (data) ->
      #     callback(data)
      #   )
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

  $(".x-editable.roster-date").editable({
    type: "date"
    showbuttons: false
  })
  $(".x-editable.roster-notes").editable({
    placeholder: "notes, ctrl-enter to submit",
    showbuttons: false
    inputclass: "input-small"
    rows: 2
  })
$(document).ready attachHandler
$(document).on "page:load", attachHandler
