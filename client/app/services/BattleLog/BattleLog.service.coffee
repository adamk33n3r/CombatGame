'use strict'

angular.module 'combatGameApp'
.factory 'BattleLog', ($resource, $http) ->
  # Used to get peoples battlelogs
  # $resource '/assets/battlelogs/:name.json',
    # name: 'test'
  get: (name) ->
    name or='test'
    $http.get "/assets/battlelogs/#{name}.json"
