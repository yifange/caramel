# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
attachColumnHandler = ->
  $("div.wc-day-column-inner").css("cursor", "pointer").on "click", ->
    date = $(this).data("date")
    window.location.href = "/events/new?date=" + date
    return false
attachEventHandler = ->
  $("div.wc-cal-event").on "click", ->
    eventId = $(this).data("eventid")
    window.location.href = "/events/" + eventId + "/edit"
    return false

$(document).ready attachColumnHandler
$(document).ready attachEventHandler
$(document).on "page:load", attachColumnHandler
$(document).on "page:load", attachEventHandler

