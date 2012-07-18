# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $('ul#cosponsors-list').hide()
  $('#more-issues').click ->
    if $('p.hidden-issue').is(':visible')
      $('p.hidden-issue').hide()
    else
      $('p.hidden-issue').show()
  $('h2#cosponsors-header').click ->
    if $('ul#cosponsors-list').is(':visible')
      $('ul#cosponsors-list').hide()
    else
      $('ul#cosponsors-list').show()
