// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery.turbolinks
//= require jquery_ujs
//= require turbolinks
//= require_tree .

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
	$('table.scroll textarea')
	$('table.scroll input')
	*/
	$('#itemForm').find('input,textarea').keydown(function() {
		targetShow(this,'button');
		$(this).css("background-color" ,notSavingColor);
	});
	$('table.scroll').find('input,textarea').keydown(function() {
		targetShow(this,'button');
		$(this).css("background-color" ,notSavingColor);
	});
	$('form').on('ajax:success', function() {
		targetHide(this,'button');
		$('input#' + $(this).attr("id") ).removeAttr( 'style' ); //this will remove all dynamic style
		$('textarea#' + $(this).attr("id") ).removeAttr( 'style' ); //this will remove all dynamic style
	});
});