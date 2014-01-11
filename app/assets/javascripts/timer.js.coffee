app = angular.module("main_timer", ['timer', 'ngResource', 'ng-rails-csrf', 'ngAnimate', 'ui.bootstrap'])

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

app.factory "Timer", ($resource) ->
  $resource "/timers/:id", { id: "@id" }

app.factory "Project", ($resource) ->
  $resource "/projects/:id", { id: "@id" },
    { update: { method: 'PUT', params: 'hourly_rate' }}

app.factory "Client", ($resource) ->
  $resource "/clients/:id", { id: "@id" }

app.factory "Activity", ($resource) ->
  $resource "/activities/:id", { id: "@id" }

@TimerCtrl = ($scope, $timeout, Timer, Project, Activity) ->

  $scope.new_timer  = {}

  $scope.selected = undefined;

  $scope.timers     = Timer.query()
  $scope.activities = Activity.query()

  $scope.new_timer_window = false

  $scope.selected_project = {}
  $scope.selected_project_show = false

  #
  # Timers
  #
  $scope.logTime = ->
    timer = Timer.save($scope.new_timer)
    $scope.timers.push(timer)
    $scope.new_timer = {}

    $timeout ->
      $scope.projects   = Project.query()
      $scope.activities = Activity.query()
    , 200

  $scope.deleteTimer = (timer) ->
    timer.$delete ->
      $scope.timers.splice($scope.timers.indexOf(timer), 1)

  # TODO: only display s if nec
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

@navbarCtrl = ($scope, $rootScope) ->

  $scope.openModal = ->
    $rootScope.$emit "openClientModal"

  $scope.openProjectModal = ->
    $rootScope.$emit "openProjectModal"    


app.run ($rootScope, Client, Project) ->
  $rootScope.modal          = { show: false }
  $rootScope.project_modal  = { show: false }
  $rootScope.projects       = Project.query()
  $rootScope.clients        = Client.query()

@newClientCtrl = ($scope, $rootScope, $timeout, Client, Project) ->
  $scope.new_client   = {}
  $scope.new_project  = {}

  $rootScope.$on "openClientModal", ->
    $scope.openModal()

  $rootScope.$on "openProjectModal", ->
    $scope.openProjectModal()

  $scope.newClient = ->
    client = Client.save($scope.new_client)
    $rootScope.clients.push(client)
    $scope.new_client = {}
    $rootScope.modal = { show: false }

  $scope.createProject = ->
    $scope.new_project.hourly_rate = $scope.new_project.hourly_rate * 100
    project = Project.save($scope.new_project)
    $rootScope.projects.push(project)
    $scope.new_project = {}
    $rootScope.project_modal = { show: false }

  $scope.openModal = ->
    $rootScope.modal = { show: true }

  $scope.openProjectModal = ->
    console.log 'open sesame'
    $rootScope.project_modal = { show: true }

  $(document).on "close", "[data-reveal]", ->
    $timeout ->
      $rootScope.modal = { show: false }
      $rootScope.project_modal = { show: false }
    , 200

app.directive "revealModal", ->
  (scope, elem, attrs) ->
    scope.$watch attrs.revealModal, (val) ->
      if val
        elem.trigger "reveal:open"
        elem.foundation('reveal', 'open')
      else
        elem.trigger "reveal:close"
        elem.foundation('reveal', 'close')
