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
//= require jquery_ujs
//= require bootstrap
//= require bootstrap-sprockets
//= require jquery.turbolinks
//= require jquery-ui/autocomplete
//= require jquery.tokeninput
//= require bootstrap/js/bootstrap.min
//= require pagespeed

//= require lazybox

//= require autoload_fb
//= require autoload_twtr
//= require blogs
//= require turbolinks

document.addEventListener("turbolinks:load", function() {
    tinymce.remove();
    tinymce.init({
        height: '300',
        selector:'textarea#blog_blog_description',
        plugins: "codesample image media link code",
        toolbar: "undo redo | styleselect | bold italic link | codesample image media |code"
    });
})














