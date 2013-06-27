$.ajaxSetup
  error: (xhr) ->
    alert "#{xhr.statusText}: #{xhr.status}"
