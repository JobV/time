angular.module('clientController',[])

  .controller 'newClientCtrl', ($scope, $rootScope, $timeout, Client, Project) ->
    $scope.new_client   = {}
    $scope.new_project  = {}

    $rootScope.$on "openClientModal", ->
      $scope.openModal()

    $rootScope.$on "openProjectModal", ->
      $scope.openProjectModal()

    $rootScope.$on "updateClient", (event, client) ->
      x.uninvoiced = client.uninvoiced if x.id == client.id for x in $rootScope.clients

    $scope.newClient = ->
      client = Client.save($scope.new_client)
      $rootScope.clients.push(client)
      $scope.new_client = {}
      $rootScope.modal = { show: false }

    $scope.createProject = ->
      $scope.new_project.hourly_rate = $scope.new_project.hourly_rate * 100
      project = Project.save($scope.new_project)
      $rootScope.projects.push(project)
      $scope.new_project = {}
      $rootScope.project_modal = { show: false }

    $scope.openModal = ->
      $rootScope.modal = { show: true }

    $scope.openProjectModal = ->
      console.log 'open sesame'
      $rootScope.project_modal = { show: true }

    $(document).on "close", "[data-reveal]", ->
      $timeout ->
        $rootScope.modal = { show: false }
        $rootScope.project_modal = { show: false }
      , 200
