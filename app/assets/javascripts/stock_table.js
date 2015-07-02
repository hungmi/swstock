targetShow = function(parent,target){
  $(target + '#' + $(parent).attr("id") ).removeClass('hidden');
}
targetHide = function(parent,target){
  $(target + '#' + $(parent).attr("id") ).addClass('hidden');
}

var notSavingColor = 'yellow';

$(document).ready(function(){
  $('input#search').select();
  $('input#search').keyup(function(){
    if ($(this).val() != '') {
      //console.log($(this).val());
      $('#searchBtn').removeClass('hidden');
    } else {
      //console.log($(this).val());
      $('#searchBtn').addClass('hidden');
    }
  });
  //中文輸入法會觸發keydown, 不會觸發keypress
  /*
  $('form#itemForm input')
  $('form#itemForm textarea')
  $('table#stock_table textarea')
  $('table#stock_table input')
  */
  
  $('#itemForm').find('input,textarea').keydown(function() {
    targetShow(this,'button');
    $(this).css("background-color" ,notSavingColor);
  });

  $('table#stock_table').find('input,textarea').keydown(function() {
    targetShow(this,'button');
    $(this).css("background-color" ,notSavingColor);
  });

  // change event is for no keydown situations
  $('#itemForm').find('input,textarea').change(function() {
    targetShow(this,'button');
    $(this).css("background-color" ,notSavingColor);
  });

  $('table#stock_table').find('input,textarea').change(function() {
    targetShow(this,'button');
    $(this).css("background-color" ,notSavingColor);
  });
  
  $('form').on('ajax:success', function() {
    targetHide(this,'button');
    $('input#' + $(this).attr("id") ).removeAttr( 'style' ); //this will remove all dynamic style
    $('textarea#' + $(this).attr("id") ).removeAttr( 'style' ); //this will remove all dynamic style
  });
});