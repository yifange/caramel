attachHandler = ->
  $.fn.editable.defaults.mode = 'inline'
  $('.x-editable-email').editable({
    url: ''
    type: 'text'
    placeholder: 'email'
  })

  $.fn.editable.defaults.mode = 'inline'
  $('.region-input').select2({
    data: [{id:0,text:'Washington'},{id:1,text:'Baltimore'},{id:2,text:'Chicago'}]
  })

  $('.x-editable-staff-name').editable({
    url: ''
    type: 'user_name'
  })

$(document).ready attachHandler
$(document).on "page:load", attachHandler
