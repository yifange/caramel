attachHandler = ->
  $.fn.editable.defaults.mode = 'inline'

  # select2 multiple
  $('.select2-mul-school').select2({
    data:[{id:0,text:'GWU'},{id:1,text:'JHU'},{id:2,text:'SJU'},{id:3,text:'ddd'}]
    multiple: true
    placeholder: 'select schools'
  })

  # select2 singular
  $('.x-editable-select2').editable({
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

  # email
  $('.x-editable-input-email').editable({
    ajaxOptions: {
      type: 'PUT'
    }
    name: 'email'
    type: 'text'
    placeholder: 'input email'
  })

  # text
  $('.x-editable-input-region').editable({
    ajaxOptions: {
      type: 'PUT'
    }
    name: 'region'
    type: 'text'
    placeholder: 'input region'
  })
  $('.x-editable-input-instrument').editable({
    ajaxOptions: {
      type: 'PUT'
    }
    type: 'text'
    placeholder: 'input instrument'
  })

  $('.x-editable-input-program-type').editable({
    ajaxOptions: {
      type: 'PUT'
    }
    type: 'text'
    placeholder: 'input program type'
  })


$(document).ready attachHandler
$(document).on "page:load", attachHandler
