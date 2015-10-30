# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("#add-stage-btn").
    data("association-insertion-method", 'after').
    data("association-insertion-node", '#stages tr.nested-fields:last-child')


  $(".ajax-input").on("ajax:send", (xhr) ->
    $(this).find('*').css 'background-color', 'pink'
    $(this).closest("table").parent().find(".ajax-text").text "請稍候..."
  ).on("ajax:error", (e, xhr, status, error) ->
    $(this).find('*').css 'background-color', 'red'
    $(this).closest("table").parent().find(".ajax-text").text $.parseJSON(xhr.responseText).error
    console.log $.parseJSON(xhr.responseText).error
  ).on("ajax:success", (e, data, status, xhr) ->
    $(this).find('*').css 'background-color', 'white'
    $(this).find('*').css 'transition', 'background-color 1s'
    $(this).closest("table").parent().find(".ajax-text").text "已存檔"
  )

  #$(".ajax-input textarea").data('value', $(".ajax-input textarea").val())
  #$(".ajax-input input").data('value', $(".ajax-input input").val())

  $(".ajax-input input, .ajax-input textarea").blur ->
    console.log "this is old: #{$(this).data('value')}"
    if $(this).data('value') isnt null || $(this).val() isnt ""
      if $(this).data('value') isnt $(this).val()
        $(this).data('value', $(this).val())
        console.log $(this).data('value')
        $(this).closest("form").submit()
