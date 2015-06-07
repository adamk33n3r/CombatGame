'use strict'

angular.module 'combatGameApp'
.controller 'GameCtrl', ($scope, Game) ->
  $scope.message = 'Hello'
  console.log Game
  Game.start()
