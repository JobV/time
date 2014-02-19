angular.module('commonFilters', [])

  .filter "iif", ->
    (input, trueValue, falseValue) ->
      (if input then trueValue else falseValue)

  .filter "truncate", ->
    (text, length, end) ->
      length = 17  if isNaN(length)
      end = "..."  if end is `undefined`
      if text.length <= length or text.length - end.length <= length
        text
      else
        String(text).substring(0, length - end.length) + end
