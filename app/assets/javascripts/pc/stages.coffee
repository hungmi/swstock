# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("#add-stage-btn").
    data("association-insertion-method", 'after').
    data("association-insertion-node", '#stages tr.nested-fields:last-child')