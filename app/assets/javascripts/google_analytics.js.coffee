analytic = ->
  if $("#google_analytics").length
    ((w, d, s, g, js, fs) ->
      g = w.gapi or (w.gapi = {})
      g.analytics =
        q: []
        ready: (f) ->
          @q.push f
          return
      js = d.createElement(s)
      fs = d.getElementsByTagName(s)[0]
      js.src = 'https://apis.google.com/js/platform.js'
      fs.parentNode.insertBefore js, fs

      js.onload = ->
        g.load 'analytics'
        return

      return
    ) window, document, 'script'
    return
  else
    return


$(document).on('turbolinks:load', analytic)