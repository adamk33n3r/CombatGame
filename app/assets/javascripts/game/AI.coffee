define ['game/Player', './Class'], (Player, Class) ->
  AI = Class.extend
    init: (player) ->
      @creator = "Adam"
      @player = player
      @moveRight = true
    act: ->
      @player.jump()
#      @player.punch()
      @moveRight = false if @player.loc.x >= window.innerWidth
      @moveRight = true if @player.loc.x <= 0
      if @moveRight
        @player.turnRight()
      else
        @player.turnLeft()
      @player.moveForward()