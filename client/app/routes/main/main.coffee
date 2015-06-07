'use strict'

angular.module 'combatGameApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'main',
    url: '/'
    templateUrl: 'app/routes/main/main.html'
    controller: 'MainCtrl'
