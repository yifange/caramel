attachNewPeopleHandler = ->
  $(".new-people").on "click", (e) ->
    identity = $(this).data("people")
    e.preventDefault()
    href = $(this).attr("href")
    $.get(href + "?people_identity=" + identity, (data, status) ->
      $(".new-people-modal-body").html($(data).find(".new-people-form-body").html())
      $(".new-people-modal").modal({
        keyboard: true
      })
    )

attachSubmitHandler = ->
  $(".new-people-modal-confirm").on "click", ->
    $form = $("form.new_people")
    $.ajax({
      type: $form.attr("method"),
      url: $form.attr("action"),
      data: $form.serialize(),
      success: (data, status) ->
        $(".new-people-modal").modal("toggle")
        $(".table").html($(data).find(".table").html())
        attachNewPeopleHandler()

      error: (data, status) ->
        $(".new-people-modal-body").html($(data.responseText).find(".new-people-form-body").html())
    })

$(document).ready attachNewPeopleHandler
$(document).ready attachSubmitHandler
$(document).on "page:load", attachNewPeopleHandler
$(document).on "page:load", attachSubmitHandler
