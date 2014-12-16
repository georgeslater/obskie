// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require forem

$('document').ready(function() {
    $('.loginInfoMenu').click(function(e) {

      e.stopPropagation();

      if ($('#userMenu').css('display') === 'none') {
        document.getElementById('userMenu').style.display = 'block';
        return $('.loginInfoArrowIcon').addClass('loginInfoArrowIconSelected');
      } else {
        document.getElementById('userMenu').style.display = 'none';
        return $('.loginInfoArrowIcon').removeClass('loginInfoArrowIconSelected');
      }
    });

    $(document).click(function(){
      console.log('click!')
  	  $("#userMenu").hide();
  	  $('.loginInfoArrowIcon').removeClass('loginInfoArrowIconSelected')
  	});
 });
