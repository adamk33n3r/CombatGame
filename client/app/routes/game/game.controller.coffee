'use strict'

angular.module 'combatGameApp'
.controller 'GameCtrl', ($scope, BattleLog, Game) ->
  $scope.message = 'Hello'
  BattleLog.get().then (response) ->
    Game.start response.data
