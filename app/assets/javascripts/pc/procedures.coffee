# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.stage-table').children('thead, tbody').toggle()
  $("#procedure-stage-panel .panel-heading").click ->
    # 要這樣才會work
    # #procedure-stage-panel
    #   .panel-heading
    #     ......
    #   .stage-table{ class: @picnum }
    #     ......
    target_stages = $(this).siblings('.stage-table.' + $(this).data('picnum')).children('thead, tbody')
    target_stages.toggle('fast')
    $(this).find('i.fa').toggleClass('fa-expand')
    $(this).find('i.fa').toggleClass('fa-compress')