attachHandler = ->
  $.fn.editable.defaults.mode = 'inline'

  # select2
  $('.select2-region').select2().select2('val', 'dddd')
  $('.select2-region').select2({
    # ajax: {
    #   type: 'PUT'
    # }
    initSelection: (element, callback) ->
      # data = {id: 1, text: 'dddddd'}
      # data = [{id: 1, text: 'GWU'}]
      # value = element.val()
      data = {id: element.val(), text: element.val()}
      # data = {id: 1, text: 'eeeeee'}
      # $(element.val().split(",")).first( ->
        # data.push({id: this, text: this})
      # )
      callback(data)
    placeholder: 'select region'
  })

  # select2 multiple
  $('.select2-mul-school').select2({
    data:[{id:0,text:'GWU'},{id:1,text:'JHU'},{id:2,text:'SJU'},{id:3,text:'ddd'}]
    multiple: true
    placeholder: 'select schools'
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

  $('.x-editable-input-email').editable({
    ajaxOptions: {
      type: 'PUT'
    }
    name: 'email'
    type: 'text'
    placeholder: 'input email'
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

  # user_name
  $('.x-editable-input-user').editable({
    ajaxOptions: {
      type: 'PUT'
    }
    type: 'user_name'
  })

$(document).ready attachHandler
$(document).on "page:load", attachHandler
