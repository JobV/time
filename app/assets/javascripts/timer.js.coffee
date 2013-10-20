#
# On start:
# -> V start running timer
# -> V create a timer (POST)
# -> V add the timer to the list, running
# ->
#
# On stop:
# -> V stop running timer
# -> set end_time (PUT)
# -> update the timer on the list
#
#
#
# This timer assumes that the requests made to the server are successful.
# 

app = angular.module("main_timer", ['timer', 'ngResource'])

#
# MODEL
#

# Change the class to whatever specified on mouseEnter
app.directive "enter", ->
  (scope, element, attrs) ->
    element.bind "mouseenter", ->
      element.addClass attrs.enter


# Change the class to whatever specified on mouseLeave
app.directive "leave", ->
  (scope, element, attrs) ->
    element.bind "mouseleave", ->
      element.removeClass attrs.enter


# Timer resources
app.factory "Timer", ($resource) ->
  $resource "/timers/:id", {id: "@id"}, 
    { stop: { 
              method: "POST", 
              params: id: "@id", 
            }
    }

#
# CONTROLLER
#

@TimerCtrl = ($scope, Timer) ->
  $scope.timers = Timer.query()

  $scope.timerRunning = false

  $scope.startClass = 'ui positive button'
  $scope.startValue = 'Start'
  $scope.startIconClass = 'play icon'

  $scope.$on 'timer-stopped', (event, data) ->
    # Do something when the timer is stopped
    console.log 'does this shit work'


  $scope.toggleTimer = ->
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
      # Post request to stop the timer
      timer = $scope.timers[$scope.timers.length - 1]
      Timer.stop(id: timer.id)

      # Stop the timer
      $scope.$broadcast('timer-stop')
      $scope.timerRunning = false

      # Adjust the button
      $scope.startClass       = 'ui positive button'
      $scope.startValue       = 'Start'


  $scope.deleteTimer = (idx) ->
    timer = $scope.timers[idx]
    timer.$delete id: timer.id, () ->
      $scope.timers.splice(idx, 1)