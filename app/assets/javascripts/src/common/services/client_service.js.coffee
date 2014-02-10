angular.module('ClientService',['ngResource'])
  .factory "Client", ($resource) ->
    $resource "/clients/:id", { id: "@id" },
      { update: { method: 'PUT' }}

