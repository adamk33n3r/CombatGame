'use strict'

angular.module 'combatGameApp'
.value 'zip', (arr1, arr2) ->
  min = Math.min arr1.length, arr2.length
  for i in [0...min]
    [arr1[i], arr2[i]]

