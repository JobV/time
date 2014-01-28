angular.module("commonDirectives", [])

  # Change the class to whatever specified on mouseEnter
  .directive "enter", ->
    (scope, element, attrs) ->
      element.bind "mouseenter", ->
        element.addClass attrs.enter

  # Change the class to whatever specified on mouseLeave
  .directive "leave", ->
    (scope, element, attrs) ->
      element.bind "mouseleave", ->
        element.removeClass attrs.enter
