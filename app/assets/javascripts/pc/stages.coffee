$ ->
  $("#add-stage-btn").
    data("association-insertion-method", 'after').
    data("association-insertion-node", '#stages tr.nested-fields:last-child')


  $(".ajax-input").on("ajax:send", (xhr) ->
    $(this).addClass('ajax-processing')
    $(this).closest("table").parent().find(".ajax-text").text "請稍候..."
  ).on("ajax:error", (e, xhr, status, error) ->
    $(this).addClass('ajax-error')
    $(this).closest("table").parent().find(".ajax-text").text $.parseJSON(xhr.responseText).error
    console.log $.parseJSON(xhr.responseText).error
  ).on("ajax:success", (e, data, status, xhr) ->
    $(this).removeClass('ajax-processing ajax-error')
    $(this).closest("table").parent().find(".ajax-text").text "已存檔"
  )

  #$(".ajax-input textarea").data('value', $(".ajax-input textarea").val())
  #$(".ajax-input input").data('value', $(".ajax-input input").val())

  $(".ajax-input input, .ajax-input textarea").on 'blur', ->
    console.log "this is old: #{$(this).data('value')}"
    if $(this).data('value') isnt null || $(this).val() isnt ""
      if $(this).data('value') isnt $(this).val()
        $(this).data('value', $(this).val())
        console.log $(this).data('value')
        $(this).closest("form").submit()

  $(".ajax-input select").change ->
    if $(this).data('value') isnt $(this).val()
      $(this).data('value', $(this).val())
      $(this).closest("form").submit()
