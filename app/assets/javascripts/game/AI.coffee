define ['game/Player'], (Player) ->
  AI =
    init: (player) ->
      @creator = "Adam"
      @player = player
      @moveRight = true
    act: ->
      @player.jump()
      @player.punch()
      @moveRight = false if @player.loc.x > window.innerWidth
      @moveRight = true if @player.loc.x < 0
      if @moveRight
        @player.move_right()
      else
        @player.move_left()