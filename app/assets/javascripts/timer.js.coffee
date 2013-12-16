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
  $resource "/timers/:id", {id: "@id"}

app.factory "Project", ($resource) ->
  $resource "/projects/:id", { id: "@id" },
    { update: { method: 'PUT', params: 'hourly_rate' }}

@TimerCtrl = ($scope, $timeout, Timer, Project) ->

  $scope.new_timer  = {}
  $scope.projects   = Project.query()
  $scope.timers     = Timer.query()

  $scope.selected_project = {}
  $scope.selected_project_show = false

  # POST
  $scope.logTime = ->
    timer = Timer.save($scope.new_timer)
    $scope.timers.push(timer)

    # Possibly replace this with $apply or something
    $timeout ->
      $scope.projects = Project.query()
    , 200

  # DELETE
  $scope.deleteTimer = (timer) ->
    timer.$delete ->
      $scope.timers.splice($scope.timers.indexOf(timer), 1)

  $scope.deleteProject = (project) ->
    project.$delete ->
      $scope.projects.splice($scope.projects.indexOf(project), 1)
      $scope.selected_project_show = false

  $scope.parseTime = (seconds) ->
    minutes           = Math.floor(seconds / 60)
    seconds_left      = Math.floor(seconds % 60)
    hours             = Math.floor(minutes / 60)
    minutes_left      = Math.floor(minutes % 60)
    return "#{hours}h #{minutes_left}m #{seconds_left}s"

  $scope.showProject = (project) ->
    $scope.selected_project = project
    $scope.selected_project.new_hourly_rate = project.hourly_rate / 100
    $scope.selected_project_show = true

  $scope.updateProject = ->
    $scope.selected_project.hourly_rate = $scope.selected_project.new_hourly_rate * 100
    $scope.selected_project.$update ->
      $scope.selected_project_show = false
