angular.module('timerController', [])

  .controller 'TimerCtrl', ($scope, $rootScope, $timeout, Timer, Project, Activity, Client) ->

    $scope.new_timer  = {}

    $scope.selected = undefined;

    $scope.timers     = Timer.query()
    $scope.activities = Activity.query()

    $scope.new_timer_window = false

    $scope.selected_project = {}
    $scope.selected_project_show = false

    $scope.start_value = "Start"

    $scope.logTime = ->
      timer = Timer.save($scope.new_timer)
      $scope.timers.push(timer)
      $scope.new_timer = {}

      # $timeout ->
      #   # considering taking out project refresh and replace with somethingsmart
      #   # $rootScope.projects   = Project.query()
      #   # $rootScope.clients    = Client.query()
      #   $scope.activities     = Activity.query()

      # , 200

    $scope.deleteTimer = (timer) ->
      timer.$delete ->
        $scope.timers.splice($scope.timers.indexOf(timer), 1)

    # TODO: only display s if nec
    $scope.parseTime = (seconds) ->
      minutes           = Math.floor(seconds / 60)
      seconds_left      = Math.floor(seconds % 60)
      hours             = Math.floor(minutes / 60)
      minutes_left      = Math.floor(minutes % 60)
      return "#{hours}h #{minutes_left}m #{seconds_left}s"

    compareTimes = (t1,t2) ->
      t1.getTime() == t2.getTime()

    $scope.start_time = null

    $scope.toggleTimer = ->
      if $scope.start_value == "Start"
        $scope.start_value = "Stop"

      else
        $scope.start_value = "Start"

