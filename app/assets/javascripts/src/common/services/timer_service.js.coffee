angular.module('TimerService', ['ngResource'])
  .factory "Timer", ($resource) ->
    $resource "/timers/:id", { id: "@id" }
