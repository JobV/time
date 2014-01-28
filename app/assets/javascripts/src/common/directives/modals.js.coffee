angular.module('modals', [])

  .directive "revealModal", ->
    (scope, elem, attrs) ->
      scope.$watch attrs.revealModal, (val) ->
        if val
          elem.trigger "reveal:open"
          elem.foundation('reveal', 'open')
        else
          elem.trigger "reveal:close"
          elem.foundation('reveal', 'close')

