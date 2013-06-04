# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#search').autocomplete
    source: "/search_suggestions"
  $('[data-behaviour~=datepicker]').datepicker
    format: 'yyyy-mm-dd'
  $('[data-resource]').editable()
  $('[data-toggle=tooltip]').tooltip()
