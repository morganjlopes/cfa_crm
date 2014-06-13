# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  hash = window.location.hash
  hash and $("ul.nav a[href=\"" + hash + "\"]").tab("show")
  $(".nav-tabs a").click (e) ->
    $(this).tab "show"
    scrollmem = $("body").scrollTop()
    window.location.hash = @hash
    $("html,body").scrollTop scrollmem
    return

  return