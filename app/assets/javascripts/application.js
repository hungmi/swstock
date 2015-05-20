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
	$(target + '#' + $(parent).attr("id") ).show();
}
targetHide = function(parent,target){
	$(target + '#' + $(parent).attr("id") ).hide();
}

$(document).ready(function(){
	$('button').hide();
	//中文輸入法會觸發keydown, 不會觸發keypress
	$('input,textarea').keydown(function() {
		targetShow(this,'button');
		$(this).css("background-color" ,"yellow");
	});
	$('form').on('ajax:success', function() {
		targetHide(this,'button');
		$('input#' + $(this).attr("id") ).removeAttr( 'style' ); //this will remove all dynamic style
		$('textarea#' + $(this).attr("id") ).removeAttr( 'style' ); //this will remove all dynamic style
	});
});