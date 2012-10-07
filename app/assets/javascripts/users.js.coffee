# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#user_area_tokens').tokenInput '/areas.json'
    theme: 'facebook'
    prePopulate: $('#user_area_tokens').data('load')

jQuery ->
  $('#user_foreign_language_tokens').tokenInput '/users/languages.json'
    theme: 'facebook'
    prePopulate: $('#user_foreign_language_tokens').data('load')