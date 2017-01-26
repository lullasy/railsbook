init = ->
  $(document).ajaxStart ->
    $('#progress').html '通信中...'
  .ajaxComplete ->
    $('#progress').html ''
  # Ajax 通信に成功したタイミングで実行
  $('#ajax_form').on 'ajax:success', (e, data) ->
    $('#result').empty()
    $.each data, ->
      $('#result').append(
        $('<li></li>').append(
          $('<a></a>').attr('href', 'http://www.wings.msn.to/index.php/-/A-03/' + @isbn).append(@title)
        )
      )

$(document).ready(init)
$(document).on('page:change', init)