angular.module("timer", []).directive "timer", [
  "$compile"
  ($compile) ->
    return (
      restrict: "E"
      replace: false
      scope:
        interval: "=interval"
        startTimeAttr: "=startTime"
        endTimeAttr: "=endTime"
        countdownattr: "=countdown"
        autoStart: "&autoStart"

      controller: [
        "$scope"
        "$element"
        "$attrs"
        "$timeout"
        ($scope, $element, $attrs, $timeout) ->
          
          #angular 1.2 doesn't support attributes ending in "-start", so we're
          #supporting both "autostart" and "auto-start" as a solution for
          #backward and forward compatibility.
          resetTimeout = ->
            clearTimeout $scope.timeoutId  if $scope.timeoutId
            return
          
          # same as stop but without the event being triggered
          calculateTimeUnits = ->
            $scope.seconds = Math.floor(($scope.millis / 1000) % 60)
            $scope.minutes = Math.floor((($scope.millis / (60000)) % 60))
            $scope.hours = Math.floor((($scope.millis / (3600000)) % 24))
            $scope.days = Math.floor((($scope.millis / (3600000)) / 24))
            return
          $scope.autoStart = $attrs.autoStart or $attrs.autostart

          $element.append $compile($element.contents())($scope)

          $scope.startTime = null
          $scope.endTime   = null
          $scope.timeoutId = null

          $scope.countdown = (if $scope.countdownattr and parseInt($scope.countdownattr, 10) >= 0 then parseInt($scope.countdownattr, 10) else `undefined`)

          $scope.isRunning = false

          $scope.$on "timer-start", ->
            $scope.start()

          $scope.$on "timer-resume", ->
            $scope.resume()

          $scope.$on "timer-stop", ->
            $scope.stop()

          $scope.$on "timer-clear", ->
            $scope.clear()

          $scope.$on "timer-set-countdown", (e, countdown) ->
            $scope.countdown = countdown

          $scope.start = $element[0].start = ->
            $scope.startTime = (if $scope.startTimeAttr then new Date($scope.startTimeAttr) else new Date())
            $scope.endTime   = (if $scope.endTimeAttr   then new Date($scope.endTimeAttr) else null)
            $scope.countdown = (if $scope.countdownattr and parseInt($scope.countdownattr, 10) > 0 then parseInt($scope.countdownattr, 10) else `undefined`)  unless $scope.countdown
            resetTimeout()
            tick()
            $scope.isRunning = true

          $scope.resume = $element[0].resume = ->
            resetTimeout()
            $scope.countdown += 1  if $scope.countdownattr
            $scope.startTime = new Date() - ($scope.stoppedTime - $scope.startTime)
            tick()
            $scope.isRunning = true

          $scope.stop = $scope.pause = $element[0].stop = $element[0].pause = ->
            $scope.clear()
            $scope.$emit "timer-stopped",
              millis: $scope.millis
              seconds: $scope.seconds
              minutes: $scope.minutes
              hours: $scope.hours
              days: $scope.days

          $scope.clear = $element[0].clear = ->
            $scope.stoppedTime = new Date()
            resetTimeout()
            $scope.timeoutId = null
            $scope.isRunning = false

          $element.bind "$destroy", ->
            resetTimeout()
            $scope.isRunning = false

          
          #determine initial values of time units and add AddSeconds functionality
          if $scope.countdownattr
            $scope.millis = $scope.countdownattr * 1000
            $scope.addCDSeconds = $element[0].addCDSeconds = (extraSeconds) ->
              $scope.countdown += extraSeconds
              $scope.$digest()
              $scope.start()  unless $scope.isRunning

            $scope.$on "timer-add-cd-seconds", (e, extraSeconds) ->
              $timeout ->
                $scope.addCDSeconds extraSeconds
                return

              return

          else
            $scope.millis = 0

          calculateTimeUnits()

          tick = ->
            $scope.millis = new Date() - $scope.startTime
            adjustment = $scope.millis % 1000
            if $scope.endTimeAttr
              $scope.millis = $scope.endTime - new Date()
              adjustment = $scope.interval - $scope.millis % 1000
            $scope.millis = $scope.countdown * 1000  if $scope.countdownattr
            if $scope.millis < 0
              $scope.stop()
              $scope.millis = 0
              calculateTimeUnits()
              return
            calculateTimeUnits()
            
            #We are not using $timeout for a reason. Please read here - https://github.com/siddii/angular-timer/pull/5
            $scope.timeoutId = setTimeout(->
              tick()
              $scope.$digest()
              return
            , $scope.interval - adjustment)
            $scope.$emit "timer-tick",
              timeoutId: $scope.timeoutId
              millis: $scope.millis

            if $scope.countdown > 0
              $scope.countdown--
            else $scope.stop()  if $scope.countdown <= 0
            return

          $scope.start()  if $scope.autoStart is `undefined` or $scope.autoStart is true
      ]
    )
]
