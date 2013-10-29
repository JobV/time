###
Settings Directive

This directive should spawn the settings menu.

angular.module("settings", []).directive "settings", ["$compile", ($compile) ->
  restrict: "E"
  replace: false # TODO -- should this be changed?
  scope:
###



