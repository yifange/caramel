attachHandler = ->
  $.fn.editable.defaults.mode = 'inline'

  # select2
  $('.select2-region').select2({
    # data: [{id:0,text:'Washington'},{id:1,text:'Baltimore'},{id:2,text:'Chicago'}]
    # option: {id:'select region', text:"haha"}
    ajax: {
      type: 'GET',
      url: "/people_page/get_regions",
      datatype: 'json',
      results: (data, page) ->
        return {results: data}
    }

    initSelection: (element, callback) ->
      data = []

      alert(element.val())
      $(element.val().split(',')).each( ->
        item = this.split(':')
        data.push({id: item[0], text: item[1]
        })
      )
      element.val('')
      callback(data)
    width: '100%'
  })

  # select2 multiple
  $('.select2-mul-school').select2({
    data:[{id:0,text:'GWU'},{id:1,text:'JHU'},{id:2,text:'SJU'},{id:3,text:'ddd'}]
    multiple: true
    placeholder: 'select schools'
  })

  # text
  $('.x-editable-region-name').editable({
    url: ''
    type: 'text'
    placeholder: 'input region'
  })

  $('.x-editable-email').editable({
    url: ''
    type: 'text'
    placeholder: 'input email'
  })

  $('.x-editable-instrument-name').editable({
    url: ''
    type: 'text'
    placeholder: 'input instrument name'
  })

  $('.x-editable-program-name').editable({
    url: ''
    type: 'text'
    placeholder: 'input program name'
  })

  # user_name
  $('.x-editable-staff-name').editable({
    url: ''
    type: 'user_name'
  })

  $('.x-editable-teacher-name').editable({
    url: ''
    type: 'user_name'
  })

  $('.x-editable-student-name').editable({
    url: ''
    type: 'user_name'
  })

$(document).ready attachHandler
$(document).on "page:load", attachHandler
