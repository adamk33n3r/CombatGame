'use strict'

angular.module 'combatGameApp'
.service 'AI', ->
  class
    constructor: (@player) ->
      @creator = "Adam"
      @moveRight = true
    act: ->
      @player.jump()
  #   @player.punch()
      @moveRight = false if @player.loc.x >= window.innerWidth
      @moveRight = true if @player.loc.x <= 0
      if @moveRight
        @player.turnRight()
      else
        @player.turnLeft()
      @player.moveForward()
