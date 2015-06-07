'use strict'

angular.module 'combatGameApp'
.config ($stateProvider) ->
  $stateProvider.state 'game',
    url: '/game'
    templateUrl: 'app/routes/game/game.html'
    controller: 'GameCtrl'
