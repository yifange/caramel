attachHandler = ->
  $.fn.editable.defaults.mode = 'inline'
  $('.first-name-input').editable({
    url: '',
    type: 'text',
    placeholder: 'first name'
  })

  $.fn.editable.defaults.mode = 'inline'
  $('.last-name-input').editable({
    url: '',
    type: 'text',
    placeholder: 'last name'
  })

  $.fn.editable.defaults.mode = 'inline'
  $('.email-input').editable({
    url: '',
    type: 'text',
    placeholder: 'email'
  })

  $.fn.editable.defaults.mode = 'inline'
  $('.region-input').select2({
    data:[{id:0,text:'Washington'},{id:1,text:'Baltimore'},{id:2,text:'Chicago'}]
  })

  $('#address').editable({
    url: '/post',
    title: 'Enter city, street and building #',
    value: {
      city: "Moscow",
      street: "Lenina",
    }
  })

$(document).ready attachHandler
$(document).on "page:load", attachHandler
