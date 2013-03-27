jQuery ->
  doEvery = (interval, func) ->
    setInterval(func, interval)

  start_polling = (a) ->
    href = a.attr('href')
    a.parent().text('Polling...')

    doEvery 5000, () ->
      $.ajax
        dataType: 'text'
        type: 'get'
        url: href
        success: (data) ->
          $('#main').html(data)
        error: (data) ->
          console.log(data)

    # location.hash = '#poll'

    false

  if location.hash == '#poll'
    start_polling $('a[rel=poll]')

  $('a[rel=poll]').click () ->
    start_polling $(this)
