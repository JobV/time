angular.module('timerController', [])

  .controller 'TimerCtrl', ($scope, $rootScope, $timeout, Timer, Project, Activity, Client) ->

    $scope.new_timer  = {}

    $scope.timers     = Timer.query()
    $scope.activities = Activity.query()

    $scope.new_timer_window = false

    $scope.logTime = ->
      timer = Timer.save $scope.new_timer, ->
        $rootScope.$emit('updateClient', timer.project.client.uninvoiced, timer.project.client)

      $scope.timers.push(timer)
      $scope.new_timer = {}

    $scope.deleteTimer = (timer) ->
      timer.$delete ->
        $scope.timers.splice($scope.timers.indexOf(timer), 1)
        $rootScope.$emit('updateClient', timer.project.client.uninvoiced - timer.total_value, timer.project.client)

    $scope.parseTime = (seconds) ->
      minutes           = Math.floor(seconds / 60)
      seconds_left      = Math.floor(seconds % 60)
      hours             = Math.floor(minutes / 60)
      minutes_left      = Math.floor(minutes % 60)
      return "#{hours}h #{minutes_left}m #{seconds_left}s"

    compareTimes = (t1,t2) ->
      t1.getTime() == t2.getTime()


    # STOPWATCH

    $scope.timerRunning = false

    $scope.toggleTimer = ->
      if $scope.timerRunning
        stopTimer()
      else
        startTimer()

    startTimer = ->
      $rootScope.$broadcast('timer-start')
      $scope.timerRunning = true

    stopTimer = ->
      $rootScope.$broadcast('timer-stop')
      $scope.timerRunning = false

    $scope.$on 'timer-stopped', (event,time) ->
      $scope.new_timer.written_time = "#{time.hours}h #{time.minutes}m #{time.seconds}s"
