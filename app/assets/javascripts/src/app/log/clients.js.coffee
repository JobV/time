angular.module('clientController',[])

  .controller 'newClientCtrl', ($scope, $rootScope, $timeout, Client, Project) ->
    $scope.new_client   = {}
    $scope.new_project  = {}
    $scope.client       = {}

    $rootScope.$on "openClientModal", ->
      $scope.openModal()

    $rootScope.$on "updateClientModal", ->
      $scope.openUpdateClientModal()

    $rootScope.$on "openProjectModal", ->
      $scope.openProjectModal()

    unbind = $rootScope.$on "updateClient", (event, value, client) ->
      for x in $rootScope.clients
        if x.id == client.id
          x.uninvoiced = value
          x.updated_at = Date()

    $scope.$on('$destroy', unbind)

    $scope.newClient = ->
      client = Client.save($scope.new_client)
      $rootScope.clients.push(client)
      $scope.new_client = {}
      $rootScope.modal = { show: false }

    $scope.updateClient = (updated_client) ->
      client = $rootScope.clients[$rootScope.clients.indexOf(updated_client)]
      client.$update ->
        $rootScope.update_client_modal = { show: false }

    $scope.createProject = ->
      $scope.new_project.hourly_rate = $scope.new_project.hourly_rate * 100
      project = Project.save $scope.new_project, ->
        console.log project.client
        for x in $rootScope.clients
          if x.id == project.client.id
            x.projects.push(project)
            x.updated_at = Date()

      $scope.new_project = {}
      $rootScope.project_modal = { show: false }

    #
    # MODALS
    #
    $scope.openModal = ->
      $rootScope.modal = { show: true }

    $scope.openUpdateClientModal = (client) ->
      $rootScope.update_client_modal = { show: true }
      $rootScope.update_client_modal.client = $rootScope.clients[$rootScope.clients.indexOf(client)]

    $scope.openProjectModal = ->
      $rootScope.project_modal = { show: true }

    $(document).on "close", "[data-reveal]", ->
      $timeout ->
        $rootScope.modal                = { show: false }
        $rootScope.project_modal        = { show: false }
        $rootScope.update_client_modal  = { show: false }
      , 200
