angular.module("main_timer", [
  'ActivityService',
  'ClientService',
  'ProjectService',
  'TimerService',
  'timer',
  'ngResource',
  'ng-rails-csrf',
  'ngAnimate',
  'ui.bootstrap',
  'commonDirectives',
  'modals',
  'navbar',
  'timerController',
  'clientController'])



  .run ($rootScope, Client, Project) ->
    $rootScope.modal          = { show: false }
    $rootScope.project_modal  = { show: false }
    $rootScope.projects       = Project.query()
    $rootScope.clients        = Client.query()
