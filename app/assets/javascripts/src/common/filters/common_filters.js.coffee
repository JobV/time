angular.module('commonFilters', [])

  .filter "iif", ->
    (input, trueValue, falseValue) ->
      (if input then trueValue else falseValue)