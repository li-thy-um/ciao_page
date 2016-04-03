# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready => 
    $('.parallax').parallax() 
    $(".button-collapse").sideNav()
    option = [{ selector: '.timeline', offset: 200, callback: 'Materialize.showStaggeredList("#timeline-list")'}]
    Materialize.scrollFire(option)