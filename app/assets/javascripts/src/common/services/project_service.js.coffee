angular.module('ProjectService', ['ngResource'])
  .factory "Project", ($resource) ->
    $resource "/projects/:id", { id: "@id" },
      { update: { method: 'PUT', params: 'hourly_rate' }}
