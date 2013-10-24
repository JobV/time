#
# On start:
# -> V start running timer
# -> V create a timer (POST)
# -> V add the timer to the list, running
# ->
#
# On stop:
# -> V stop running timer
# -> V set end_time (PUT)
# -> V update the timer on the list
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

  # get all timers
  $scope.timers = Timer.query ->
    if aTimerIsRunning($scope.timers)
      # TODO: set the time correctly
      $scope.startClass = 'ui red button'
      $scope.startValue = 'Stop'
    else
      $scope.startClass = 'ui positive button'
      $scope.startValue = 'Start'


  $scope.$on 'timer-stopped', (event, data) ->
    # Do something when the timer is stopped

  $scope.toggleTimer = ->
    if aTimerIsRunning($scope.timers)

      # call stop on api; update dom; stop ng timer
      timer = $scope.timers[$scope.timers.length - 1]
      $scope.timers[$scope.timers.length - 1] = Timer.stop(id: timer.id)
      $scope.$broadcast('timer-stop')

      # Adjust styles
      $scope.startClass = 'ui positive button'
      $scope.startValue = 'Start'

    else

      # Create and start a new timer
      timer = Timer.save($scope.newTimer)
      $scope.timers.push(timer)
      $scope.newTimer = {}
      $scope.$broadcast('timer-start')

      # Adjust styles
      $scope.startClass = 'ui red button'
      $scope.startValue = 'Stop'


  $scope.deleteTimer = (idx) ->
    timer = $scope.timers[idx]
    timer.$delete id: timer.id, () ->
      $scope.timers.splice(idx, 1)

  aTimerIsRunning = (timers) ->
    if (timers.length == 0)
      return false
    else
      if (!timers[timers.length-1].end_time)
        return true

      return false
