app = angular.module("main_timer", ['timer', 'ngResource'])

app.directive "enter", ->
  (scope, element, attrs) ->
    element.bind "mouseenter", ->
      element.addClass attrs.enter


app.directive "leave", ->
  (scope, element, attrs) ->
    element.bind "mouseleave", ->
      element.removeClass attrs.enter


app.factory "Timer", ($resource) ->
  $resource "/timers/:id", {id: "@id"}, 
    {update: {method: "PUT"}},
    {delete_timer: {method: "DELETE"}}
    {stop_timer: {method: "POST"}}

@TimerCtrl = ($scope, Timer) ->
  $scope.timers = Timer.query()

  $scope.timerRunning = false

  $scope.startClass = 'ui positive button'
  $scope.startValue = 'Start'
  $scope.startIconClass = 'play icon'

  $scope.addTimer = (stopTime = Date.new) ->
    if $scope.timerRunning == false

      # POST
      timer = Timer.save($scope.newTimer)
      $scope.timers.push(timer)
      $scope.newTimer = {}

      # Start running timer
      $scope.$broadcast('timer-start')
      $scope.timerRunning = true

      # Set start button values
      $scope.startClass = 'ui red button'
      $scope.startValue = 'Stop'

    else
      # timer = $scope.timers.last()
      # timer.$update(end_time: stopTime)

      $scope.$broadcast('timer-stop')
      timer.
      $scope.timerRunning     = false
      $scope.startClass       = 'ui positive button'
      $scope.startValue       = 'Start'
      $scope.startIconClass   = 'play icon'

  $scope.deleteTimer = (idx) ->
    timer = $scope.timers[idx]
    timer.$delete id: timer.id, () ->
      $scope.timers.splice(idx, 1)

  $scope.totalTime = ->
    timer = $scope.timers[idx]
    today = new Date
    time = timer.created_at - Date.new()
    return today

  $scope.stopTimer = (idx) ->
    timer = $scope.timers[idx]
    timer.$update { id: timer.id, end_time: new Date }



