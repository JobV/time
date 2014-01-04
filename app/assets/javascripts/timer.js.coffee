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

app.run ($rootScope) ->
  $rootScope.modal = {show: false}

@newClientCtrl = ($scope, $rootScope, $timeout, Client) ->
  $scope.new_client = {}

  $scope.newClient = ->
    client = Client.save($scope.new_client)
    $scope.clients.push(client)

  $scope.clients = Client.query()

  $scope.openModal = ->
    $rootScope.modal = { show: true }

  $(document).on "close", "[data-reveal]", ->
    $timeout ->
      $rootScope.modal = { show: false }
    , 200

app.directive "revealModal", ($rootScope) ->
  (scope, elem, attrs) ->
    scope.$watch attrs.revealModal, (val) ->
      if val
        elem.trigger "reveal:open"
        elem.foundation('reveal', 'open')
      else
        elem.trigger "reveal:close"
        elem.foundation('reveal', 'close')
