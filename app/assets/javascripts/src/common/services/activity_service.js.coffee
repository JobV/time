angular.module('ActivityService', ['ngResource'])
  .factory "Activity", ($resource) ->
    $resource "/activities/:id", { id: "@id" }
