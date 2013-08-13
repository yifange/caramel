initEditable = ->
  $(".editable.roster-date").editable({
  })


$(document).ready initEditable
$(document).on "page:load", initEditable
