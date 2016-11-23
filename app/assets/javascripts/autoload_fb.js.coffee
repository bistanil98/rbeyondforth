
obj = this #defining obj for making fbIntervalId global

#update method definition for sending ajax request to given url
update = ->
  $.ajax url: 'fb_data'
  return

#fb_calls method definition for calling the update method in time-intervals if fb-home element is found on the current page
fb_calls = ->
  if $("#fb_home").length
    obj.fbIntervalId = setInterval(update, 120000)
    #alert(obj.fbIntervalId)
    return
  else
    #alert(obj.fbIntervalId+"fb_home element not found in this page")
    clearInterval obj.fbIntervalId
    return


$(document).on('turbolinks:load', fb_calls) #this line listens for page load which is what turbo links will trigger when the DOM is loaded.