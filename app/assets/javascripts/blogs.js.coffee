# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
methodCalls = ->
  #script for categories autocomplete
  if $('#blog_blog_category_name').length
    $('#blog_blog_category_name').autocomplete
      source: $('#blog_blog_category_name').data('autocomplete-source')
  #script for tags input
  if $('#blog_tag_tokens').length
    $('#blog_tag_tokens').tokenInput '/tags.json',
      theme: 'facebook'
      preventDuplicates: true
      minChars: 2
      prePopulate: $('#blog_tag_tokens').data('load-source')
      onResult: (results) ->
        $.each results, (index, value) ->
          value.name = value.tag_name
          return
        results
  if $('.card-blockquote img').length
    $('.card-blockquote img').each ->
      $(this).css({'width':'100%','height':'80vh'})


$(document).on('turbolinks:load', methodCalls) #calls the autoCompleteMethod each time turbolinks are loaded
