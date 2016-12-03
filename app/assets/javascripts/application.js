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

//= require jquery
//= require bootstrap
//= require bootstrap-sprockets
//= require jquery.turbolinks
//= require jquery-ui/autocomplete
//= require jquery_ujs
//= require jquery.tokeninput
//= require pagespeed
//= require_tree
//= require spin
//= require lazybox
//= require google_analytics
//= require autoload_fb
//= require autoload_twtr
//= require ajax.spin
//= require admin/js/plugins/flot/excanvas.min
//= require admin/js/plugins/flot/flot-data
//= require admin/js/plugins/flot/jquery.flot
//= require admin/js/plugins/flot/jquery.flot.pie
//= require admin/js/plugins/flot/jquery.flot.resize
//= require admin/js/plugins/flot/jquery.flot.tooltip.min
//= require admin/js/plugins/morris/morris
//= require admin/js/plugins/morris/morris.min
//= require admin/js/plugins/morris/morris-data
//= require admin/js/plugins/morris/raphael.min
//= require turbolinks
$(document).on('turbolinks:load', function() {

});
document.addEventListener("turbolinks:load", function() {
    tinymce.remove();
    tinymce.init({
        height: '300',
        selector:'textarea#blog_blog_description',
        plugins: "codesample image media link code",
        toolbar: "undo redo | styleselect | bold italic link | codesample image media |code"
    });
})














