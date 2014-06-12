define(['underscore', 'jquery'], ->
  showName = (n) ->
    temp = _.template("Hello <%= name %>")
    $("body").html(temp(name: n))
  return
    showName: showName
