'use strict'

angular.module 'combatGameApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'admin',
    url: '/admin'
    templateUrl: 'app/routes/admin/admin.html'
    controller: 'AdminCtrl'
