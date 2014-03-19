do ->
  injectAccessToken = ->
    link = $(this)
    link.data('original', link.attr('href')) unless link.data('original')
    link.attr('href', "#{link.data('original')}?access_token=#{$('#access-token').val()}")

  loadSuccess = (data) ->
    $('.response').html(data)
    $('.export').show()

  loadFailure = ->
    $('.message').html("That didn't work so well. Are you sure your access token is correct?").show()

  loadComplete = ->
    $('.loading').hide()

  loadTheEmoticons = ->
    accessToken = $('#access-token').val()

    if accessToken != $(document).data('last-access-token')
      $('.loading').show()
      $('.message').hide()
      $('.response').html('')
      $('.export').hide()

      $.ajax('emoticons',
        data: {access_token: accessToken}
        success: loadSuccess
        error: loadFailure
        complete: loadComplete
      )

      $(document).data('last-access-token', accessToken)

  $(document).on('submit', 'form', (e) -> e.preventDefault(); $('#access-token').trigger('blur'))
             .on('paste', '#access-token', -> setTimeout(loadTheEmoticons, 100))
             .on('change', '#access-token', loadTheEmoticons)
             .on('click', '.export', injectAccessToken)

  $('#access-token').focus()

