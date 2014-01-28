angular.module('timerController', [])

  .controller 'TimerCtrl', ($scope, $rootScope, $timeout, Timer, Project, Activity, Client) ->

    $scope.new_timer  = {}

    $scope.timers     = Timer.query()
    $scope.activities = Activity.query()

    $scope.logTime = ->
      timer = Timer.save($scope.new_timer) ->
        $scope.timers.push(timer)
        
        $rootScope.projects.indexOf($scope.new_timer.project_name)

        $scope.new_timer = {}


    $scope.deleteTimer = (timer) ->
      timer.$delete ->
        $scope.timers.splice($scope.timers.indexOf(timer), 1)

    $scope.parseTime = (seconds) ->
      minutes           = Math.floor(seconds / 60)
      seconds_left      = Math.floor(seconds % 60)
      hours             = Math.floor(minutes / 60)
      minutes_left      = Math.floor(minutes % 60)
      return "#{hours}h #{minutes_left}m #{seconds_left}s"
