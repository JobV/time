#
# This timer assumes that the requests made to the server are successful.
# 
app = angular.module("main_timer", ['timer', 'ngResource', 'ng-rails-csrf', 'ui.select2', 'ngAnimate'])

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
  $resource "/timers/:id", { id: "@id" }

app.factory "Project", ($resource) ->
  $resource "/projects/:id", { id: "@id" },
    { update: { method: 'PUT', params: 'hourly_rate' }}

app.factory "Client", ($resource) ->
  $resource "/clients/:id", { id: "@id" }

@TimerCtrl = ($scope, $timeout, Timer, Project, Client) ->

  $scope.new_timer  = {}
  $scope.projects   = Project.query()

  $scope.timers = Timer.query()

  $scope.project_select2_options = {
    placeholder: "Project",
    dropDownCssClass: "select2_project",
    containerCssClass: "select2_project"
  }

  $scope.new_timer_window = false

  # TODO: Dry this up
  fl_today = (x) ->
    d1 = new Date Date.parse(x.created_at)
    d2 = new Date()
    d1.setHours(0,0,0,0)
    d2.setHours(0,0,0,0)
    d1.getTime() == d2.getTime()

  fl_yesterday = (x) ->
    d1 = new Date Date.parse(x.created_at)
    d2 = new Date()
    d2.setDate(d2.getDate() - 1)
    console.log d2
    d1.setHours(0,0,0,0)
    d2.setHours(0,0,0,0)
    d1.getTime() == d2.getTime()

  fl_this_week = (x) ->
    d1 = new Date Date.parse(x.created_at)
    d2 = new Date()
    d2.setDate(d2.getDate() - 7)
    console.log d2
    d1.setHours(0,0,0,0)
    d2.setHours(0,0,0,0)
    d1.getTime() >= d2.getTime()


  $scope.selected_project = {}
  $scope.selected_project_show = false

  #
  # Timers
  #
  $scope.logTime = ->
    timer = Timer.save($scope.new_timer)
    $scope.timers.push(timer)

    $timeout ->
      $scope.projects = Project.query()
    , 200

  $scope.deleteTimer = (timer) ->
    timer.$delete ->
      $scope.timers.splice($scope.timers.indexOf(timer), 1)

  $scope.parseTime = (seconds) ->
    minutes           = Math.floor(seconds / 60)
    seconds_left      = Math.floor(seconds % 60)
    hours             = Math.floor(minutes / 60)
    minutes_left      = Math.floor(minutes % 60)
    return "#{hours}h #{minutes_left}m #{seconds_left}s"

  compareTimes = (t1,t2) ->
    t1.getTime() == t2.getTime()

  #
  # Projects
  #
  $scope.deleteProject = (project) ->
    project.$delete ->
      $scope.projects.splice($scope.projects.indexOf(project), 1)
      $scope.selected_project_show = false

  $scope.showProject = (project) ->
    $scope.selected_project = project
    $scope.selected_project.new_hourly_rate = project.hourly_rate / 100
    $scope.selected_project_show = true

  $scope.updateProject = ->
    $scope.selected_project.hourly_rate = $scope.selected_project.new_hourly_rate * 100
    $scope.selected_project.$update ->
      $scope.selected_project_show = false

  #
  # Clients
  #
  $scope.clients = Client.query()
  $scope.new_client = {}

  $scope.newClient = ->
    client = Client.save($scope.new_client)
    $scope.clients.push(client)
