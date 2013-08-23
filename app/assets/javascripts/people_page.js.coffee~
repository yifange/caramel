attachResetPwdHandler = ->
  $('.reset-pwd').on "click", ->
    toBeReset = "input[type=checkbox]:checked"
    $( toBeReset ).each(i, val) ->
    $.ajax(
      type: "POST"
      url:
    )

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
      url: "/programs/destroy_multi",
      success: (data, status) ->
        cur_pane_id = $(".tab-pane.active").attr("id")
        console.log $(data).html()
        $(".tab-pane.active").html($(data).find("#" + cur_pane_id).html())
        attachBlockHandler()
        attachNewEntryHandler()
        attachTagClickHandler()
        attachDeleteEntryHandler()
    )

attachNewEntryHandler = ->
  $(".new-entry").on "click", (e) ->
    identity = $(this).data("entry")
    e.preventDefault()
    href = $(this).attr("href")
    $.get(href + "?entry_identity=" + identity, (data, status) ->
      $(".new-entry-modal-body").html($(data).find(".new-entry-form-body").html())
      attachBlockHandler()
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
        # $(".table").html($(data).find(".table").html())
        cur_pane_id = $(".tab-pane.active").attr("id")
        $(".tab-pane.active").html($(data).find("#" + cur_pane_id).html())
        attachNewEntryHandler()
        attachBlockHandler()
        attachTagClickHandler()
        attachDeleteEntryHandler()

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

$(document).ready attachBlockHandler
$(document).ready attachResetPwdHandler
$(document).ready attachDeleteEntryHandler
$(document).ready attachNewEntryHandler
$(document).ready attachSubmitHandler
$(document).ready attachTagClickHandler
$(document).ready attachTooltipHandler
$(document).on "page:load", attachBlockHandler
$(document).on "page:load", attachResetPwdHandler
$(document).on "page:load", attachDeleteEntryHandler
$(document).on "page:load", attachNewEntryHandler
$(document).on "page:load", attachSubmitHandler
$(document).on "page:load", attachTagClickHandler
$(document).on "page:load", attachTooltipHandler






# attachMyBlockHandler = ->
#   $.fn.editable.defaults.mode = 'inline'
#
#   # $(".instrument-options").editable({
#   #   showbuttons: false
#   # })
#
#   # $('.course-type-options').editable({
#   #   showbuttons: false
#   # })
#
#   # $('.regular-courses-per-year').editable({
#   #   showbuttons: false
#   # })
#
#   # $('.group-courses-per-year').editable({
#   #   showbuttons: false
#   # })
#
#   $(".teacher-options").on("select2-blur", ->
#     $.ajax(
#       type: "POST",
#       url: "/programs_page/save_teachers",
#       data: {value: $(this).val(), pk: $(this).data("pk")},
#       dataType: "json", results: (data, page) ->
#         return {results: data}
#     )
#   )
#
#   $(".teacher-options").select2({
#     ajax: {
#       type: "GET",
#       url: "/programs_page/get_teachers",
#       dataType: "json",
#       results: (data, page) ->
#         return {results: data}
#     }
#     initSelection: (element, callback) ->
#       data = []
#       $(element.val().split(",")).each( ->
#         item = this.split(":")
#         data.push({
#           id: item[0], text: item[1]
#         })
#       )
#       element.val('')
#       callback(data)
#     width: '100%',
#     multiple: true
#   })
#
#   $(".student-options").on("select2-blur", ->
#     $.ajax(
#       type: "POST",
#       url: "/programs_page/save_students",
#       data: {value: $(this).val(), pk: $(this).data("pk")},
#       dataType: "json", results: (data, page) ->
#         return {results: data}
#     )
#   )
#
#   $(".student-options").select2({
#     ajax: {
#       type: "GET",
#       url: "/programs_page/get_students",
#       dataType: "json",
#       results: (data, page) ->
#         return {results: data}
#     }
#     initSelection: (element, callback) ->
#       data = []
#       $(element.val().split(",")).each( ->
#         item = this.split(":")
#         data.push({
#           id: item[0], text: item[1]
#         })
#       )
#       element.val('')
#       callback(data)
#     width: '100%',
#     multiple: true
#   })
#
#   $(".teacher-options").on "change", ->
#     attachTagClickHandler()
#
#   $(".student-options").on "change", ->
#     attachTagClickHandler()
