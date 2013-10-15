app = angular.module("main_timer", ['timer', 'ngResource'])

@TimerCtrl = ($scope, $resource) ->
  Timer = $resource("/timers/:id", {id: "@id"}, {update: {method: "PUT"}})
  $scope.timers = Timer.query()

  $scope.addTimer =->
    timer = Timer.save($scope.newTimer)
    $scope.timers.push(timer)
    $scope.newTimer = {}

  $scope.timerRunning = false
  $scope.startValue = 'Start'
  $scope.stopClass = 'ui disabled button'
  $scope.startIconClass = 'play icon'

  $scope.startTimer =  ->
    $scope.$broadcast('timer-start')
    $scope.timerRunning = true

    $scope.startClass = 'ui button'
    $scope.startValue = 'Pause'
    $scope.startIconClass   = 'pause icon'

    $scope.stopClass  = 'ui button'

  $scope.stopTimer = ->
    $scope.$broadcast('timer-stop')
    $scope.timerRunning = false

    $scope.startClass = 'ui button'
    $scope.startValue = 'Start'
    $scope.startIconClass   = 'play icon'

    $scope.stopClass  = 'ui disabled button'





