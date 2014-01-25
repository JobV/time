###
angular-timer - v1.0.5 - 2013-10-11 2:25 PM
https://github.com/siddii/angular-timer

Copyright (c) 2013 Siddique Hameed
Licensed MIT <https://github.com/siddii/angular-timer/blob/master/LICENSE.txt>
###

angular.module("timer", []).directive "timer", ["$compile", ($compile) ->
  restrict: "E"
  replace: false
  scope:
    interval: "=interval"
    startTimeAttr: "=startTime"
    countdownattr: "=countdown"
    autoStart: "&autoStart"

  controller: ["$scope", "$element", "$attrs", ($scope, $element, $attrs) ->
    
    #angular 1.2 doesn't support attributes ending in "-start", so we're
    #supporting both "autostart" and "auto-start" as a solution for
    #backward and forward compatibility.
    resetTimeout = ->
      clearTimeout $scope.timeoutId  if $scope.timeoutId

    calculateTimeUnits = ->
      $scope.seconds  = Math.floor(($scope.millis   / (1000)) % 60)
      $scope.minutes  = Math.floor((($scope.millis  / (60000)) % 60))
      $scope.hours    = Math.floor((($scope.millis  / (3600000)) % 24))
      $scope.days     = Math.floor((($scope.millis  / (3600000)) / 24))

    $scope.autoStart = $attrs.autoStart or $attrs.autostart
    $element.append $compile("<span>{{millis}}</span>")($scope)  if $element.html().trim().length is 0
    $scope.startTime = null
    $scope.timeoutId = null
    $scope.countdown = (if $scope.countdownattr and parseInt($scope.countdownattr, 10) >= 0 then parseInt($scope.countdownattr, 10) else `undefined`)
    $scope.isRunning = false
    $scope.$on "timer-start", ->
      $scope.start()

    $scope.$on "timer-resume", ->
      $scope.resume()

    $scope.$on "timer-stop", ->
      $scope.stop()

    $scope.start = $element[0].start = ->
      $scope.startTime = (if $scope.startTimeAttr then new Date($scope.startTimeAttr) else new Date())
      $scope.countdown = (if $scope.countdownattr and parseInt($scope.countdownattr, 10) > 0 then parseInt($scope.countdownattr, 10) else `undefined`)
      resetTimeout()
      tick()

    $scope.resume = $element[0].resume = ->
      resetTimeout()
      $scope.countdown += 1  if $scope.countdownattr
      $scope.startTime = new Date() - ($scope.stoppedTime - $scope.startTime)
      tick()

    $scope.stop = $scope.pause = $element[0].stop = $element[0].pause = ->
      $scope.stoppedTime = new Date()
      resetTimeout()
      $scope.$emit "timer-stopped",
        millis: $scope.millis
        seconds: $scope.seconds
        minutes: $scope.minutes
        hours: $scope.hours
        days: $scope.days

      $scope.timeoutId = null

    $element.bind "$destroy", ->
      resetTimeout()

    
    #determine initial values of time units
    if $scope.countdownattr
      $scope.millis = $scope.countdownattr * 1000
    else
      $scope.millis = 0
    calculateTimeUnits()
    
    tick = ->
      $scope.millis = new Date() - $scope.startTime
      adjustment = $scope.millis % 1000
      $scope.millis = $scope.countdown * 1000  if $scope.countdownattr
      calculateTimeUnits()
      if $scope.countdown > 0
        $scope.countdown--
      else if $scope.countdown <= 0
        $scope.stop()
        return
      
      #We are not using $timeout for a reason. Please read here - https://github.com/siddii/angular-timer/pull/5
      $scope.timeoutId = setTimeout(->
        tick()
        $scope.$digest()
      , $scope.interval - adjustment)
      $scope.$emit "timer-tick",
        timeoutId: $scope.timeoutId
        millis: $scope.millis


    $scope.start()  if $scope.autoStart is `undefined` or $scope.autoStart is true
  ]
]
