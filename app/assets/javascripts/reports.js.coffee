buttonTextFunc = (singularText, pluralText, maxNum, options) ->
  caret = "<b class='caret'></b>"
  if (options.length == 0)
    singularText + " " + caret
  else if (options.length > maxNum)
    options.length + " " + pluralText + " " + caret
  else
    buttonTitleFunc(options) + " " + caret

buttonTitleFunc = (options) ->
  selected = []
  options.each ->
    selected.push($(this).text().trim())
    selected.join(", ")
  selected
multiselectConfigs = (singular, plural, dropRight) ->
  {
    buttonText: (options) ->
      buttonTextFunc(singular, plural, 1, options)
    buttonTitle: (options) ->
      buttonTitleFunc(options)
    includeSelectAllOption: true
    dropRight: dropRight
    enableFiltering: true
    selectedClass: null
    enableCaseInsensitiveFiltering: true
  }
multiselectInit = ->
  # $(".multiselect").tooltip({
  #   placement: "bottom"
  # })
  $(".multiselect#student-filter").multiselect(multiselectConfigs("student", "students", false))

  $(".multiselect#school-filter").multiselect( multiselectConfigs("school", "schools", false))

  $(".multiselect#teacher-filter").multiselect(multiselectConfigs("teacher", "teachers", false))

  $(".multiselect#category-filter").multiselect(multiselectConfigs("category", "categories", true))

hideAllButtonHandler = ->
  $(".hide-all").on "click", ->
    $icon = $(this).children()
    $icon.toggleClass("icon-eye-close").toggleClass("icon-eye-open")
    if $icon.hasClass("icon-eye-close")
      $(this).attr("title", "Hide all details")
      $(".accordion-body").show(50)
    else
      $(this).attr("title", "Show all details")
      $(".accordion-body").hide(50)

$(document).ready multiselectInit
$(document).on "page:load", multiselectInit
$(document).ready hideAllButtonHandler
$(document).on "page:load", hideAllButtonHandler