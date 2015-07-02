$(document).ready(function(){
  //$('.stock_table_clipboard').text('123');
  $('.stock_table_clipboard').click(function(){
    $(this).select();
  })

  $('.stock_table_clipboard').keydown(function(s){
    if (s.keyCode == '67') {
      console.log('123');
      $(this).css("background-color", "TOMATO");
    }
  })
});