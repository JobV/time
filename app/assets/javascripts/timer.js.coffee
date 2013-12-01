#
# This timer assumes that the requests made to the server are successful.
# 

app = angular.module("main_timer", ['timer', 'ngResource', 'ng-rails-csrf'])

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

app.factory "Project", ($resource) ->
  $resource "/projects/:id", { id: "@id" }


#
# CONTROLLER
#

@TimerCtrl = ($scope, Timer) ->

  $scope.startingTime = 33

  $scope.timers = Timer.query ->
    if aTimerIsRunning($scope.timers)

      # Set starting time to the time the timer was created
      # $scope.startingTime = calculateStartingTime($scope.timers)
      # $scope.$broadcast('timer-start')
      
    else
      # no timer is running

  $scope.$on 'timer-stopped', (event, data) ->
    # Do something when the timer is stopped


  $scope.toggleTimer = ->
    console.log 'ding'

    timer = Timer.save($scope.newTimer)
    $scope.timers.push(timer)
    $scope.newTimer = {}
    $scope.$broadcast('timer-start')

    # if aTimerIsRunning($scope.timers)
    #   # call stop on api; update dom; stop ng timer
    #   timer = $scope.timers[$scope.timers.length - 1]
    #   $scope.timers[$scope.timers.length - 1] = Timer.stop(id: timer.id)
    #   $scope.$broadcast('timer-stop')

    # else

    #   # Set startingtime to 0
    #   $scope.startingTime = 0

    #   # Create and start a new timer
    # timer = Timer.save($scope.newTimer)
    # $scope.timers.push(timer)
    # $scope.newTimer = {}
    # $scope.$broadcast('timer-start')


  $scope.deleteTimer = (idx) ->
    # TODO: if this timer is running, reset the timer
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


  calculateStartingTime = (timers) ->
    timer = timers[timers.length-1]
    starting_time = new Date - Date.parse(timer.created_at)
    console.log 'calculated starting time:'
    console.log starting_time
    return starting_time


@BarCtrl = ($scope, Project, Timer) ->
  $scope.new_timer = {}
  
  $scope.projects = Project.query ->
    # Do something on a succesful query

  $scope.logTime = ->
    timer = Timer.save($scope.new_timer)
