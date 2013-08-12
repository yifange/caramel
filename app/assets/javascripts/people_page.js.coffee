attachNewEntryHandler = ->
  $(".new-entry").on "click", (e) ->
    identity = $(this).data("entry")
    e.preventDefault()
    href = $(this).attr("href")
    $.get(href + "?entry_identity=" + identity, (data, status) ->
      $(".new-entry-modal-body").html($(data).find(".new-entry-form-body").html())
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
        $(".table").html($(data).find(".table").html())
        attachNewEntryHandler()

      error: (data, status) ->
        $(".new-entry-modal-body").html($(data.responseText).find(".new-entry-form-body").html())
        # $.get(href + "?entry_identity=" + identity, (data, status) ->
        # $(".new-entry-modal").show()
        # $(".new-entry-modal-body").html($(data).find(".new-entry-modal-body").html())
        # $(".new-entry-modal").modal({
        #   keyboard: true
        # })
    })

$(document).ready attachNewEntryHandler
$(document).ready attachSubmitHandler
$(document).on "page:load", attachNewEntryHandler
$(document).on "page:load", attachSubmitHandler
