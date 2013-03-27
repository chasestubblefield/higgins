jQuery ->
  $('a[href$=enqueue]').click (e) ->
    e.target.hash = 'poll'
