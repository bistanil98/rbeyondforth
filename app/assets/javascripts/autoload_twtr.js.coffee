obj1 = this  #defining obj for making fbIntervalId global

#update method definition for sending ajax request to given url

update = ->
  $.ajax url: 'refresh_twtr_home'
  return

#twtr_calls method definition for calling the update method in time-intervals if twtr-home element is found on the current page
twtr_calls = ->
  if $("#twtr_home").length
    obj1.twtrIntervalId = setInterval(update, 120000)
    #alert(obj1.twtrIntervalId)
    return
  else
    clearInterval obj1.twtrIntervalId
    #alert("twtr_home element not found on this page")
    return

#calls method call
$(document).on('turbolinks:load', twtr_calls) #this line listens for page load which is what turbo links will trigger when the DOM is loaded.