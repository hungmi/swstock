# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.stage-table').children('thead, tbody').toggle()
  $("#procedure-stage-panel .panel-heading").click ->
    target_stages = $('.stage-table.' + $(this).data('picnum')).children('thead, tbody')
    target_stages.toggle('fast')
    $(this).find('span.glyphicon').toggleClass('glyphicon-resize-small')