# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# attachTagClickHandler = ->
#
#   clickHandlerA = ->
#     $(".select2-search-choice").unbind("click")
#     $(".select2-search-choice").bind("click", clickHandlerA)
#     $( ->
#       $(".select2-search-choice").popover()
#     )
#   $(".select2-search-choice").bind("click", clickHandlerA)

# attachHandler = ->
#   $.fn.editable.defaults.mode = 'inline'
#
#   $(".instrument-options").editable({
#     showbuttons: false
#   })
#
#   $('.course-type-options').editable({
#     showbuttons: false
#   })
#
#   $('.regular-courses-per-year').editable({
#     showbuttons: false
#   })
#
#   $('.group-courses-per-year').editable({
#     showbuttons: false
#   })
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

# attachNewProgramHandler = ->
#   $(".new-entry").on "click", (e) ->
#     alert "lalal"
#     e.preventDefault()
#     href = $(this).attr("href")
#     $.get(href + "?school_id=" + $(this).data("entry"), (data, status) ->
#       $("#new-entry-modal-body").html($(data).find("#new-entry-form-body").html())
#       attachHandler()
#       $("#new-entry-modal").modal({
#         keyboard: true
#       })
#     )
# attachTooltipHandler = ->
#   $("a.tab-hover").tooltip({
#     placement: "bottom"
#   })
# attachSubmitHandler = ->
#   $("#new-entry-modal-confirm").on "click", ->
#     $form = $("form.new_entry")
#     $.ajax({
#       type: $form.attr("method"),
#       url: $form.attr("action"),
#       data: $form.serialize(),
#       success: (data, status) ->
#         $("#new-entry-modal").modal("toggle")
#         cur_pane_id = $(".tab-pane.active").attr("id")
#         $(".tab-pane.active").html($(data).find("#" + cur_pane_id).html())
#         attachNewProgramHandler()
#         attachHandler()
#         attachTagClickHandler()
#
#       error: (data, status) ->
#         $("#new-entry-modal-body").html($(data.responseText).find("#new-entry-form-body").html())
#     })


# $(document).ready attachHandler
# $(document).ready attachDeleteEntryHandler
# $(document).ready attachNewProgramHandler
# $(document).ready attachSubmitHandler
# $(document).ready attachTooltipHandler
# $(document).ready attachTagClickHandler
# $(document).on "page:load", attachHandler
# $(document).on "page:load", attachDeleteEntryHandler
# $(document).on "page:load", attachNewProgramHandler
# $(document).on "page:load", attachSubmitHandler
# $(document).on "page:load", attachTooltipHandler
# $(document).on "page:load", attachTagClickHandler
