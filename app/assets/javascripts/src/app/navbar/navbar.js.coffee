angular.module('navbar',[])

  .controller 'navbarCtrl', ($scope, $rootScope) ->

    $scope.openModal = ->
      $rootScope.$emit "openClientModal"

    $scope.openProjectModal = ->
      $rootScope.$emit "openProjectModal"    
