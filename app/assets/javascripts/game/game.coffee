define ['game/Player', 'game/AI'], (Player, AI) ->
  console.log "loading game.coffee"
  game =
    cursor:
      x:0
      y:0
      rotation:0
    players: null
    draw: (gfx) ->
      # Clear screen
      gfx.clear("#000000")

      @update()
      for player in @players
        player.draw(gfx)

      # Draws cursor
      # Log
      gfx.save()
        .translate(@cursor.x, @cursor.y)
        .rotate(-135 * Math.PI / 180)
        .fillStyle("white")
        .fillRect(-8,0,16,50)
        .restore()
      # Big square
      gfx.save()
        .translate(@cursor.x,@cursor.y)
        .rotate(@cursor.rotation)
        .fillStyle("darkgrey")
        .fillRect(-30/2, -30/2, 30, 30)
        .restore()
      # Small square
      gfx.save()
        .translate(@cursor.x,@cursor.y)
        .rotate(-@cursor.rotation)
        .fillStyle("grey")
        .fillRect(-16/2, -16/2, 16, 16)
        .restore()
    update: ->
      for player in @players
        player.update()
      for player in @players
        player.act()
      return null

#      console.log @player.velocity.x
    onresize: (width, height) ->
      console.log "resizing"
      @gfx.canvas.width = width
      @gfx.canvas.height = height - 45
      @gfx.canvas.getContext("2d").translate(0, @gfx.canvas.height)
      @gfx.canvas.getContext("2d").scale(1, -1)
#        gameArea = $('#game_area')[0]
#        gameArea.style.fontSize = (newWidth / 400) + 'em'; // Must use em in child elements
    onmousemove: (x, y) ->
      # save mouse x, y
      @cursor.x = x
      @cursor.y = @gfx.canvas.height - y
    ontouchmove: (x, y) ->
      # save mouse x, y
      @cursor.x = x
      @cursor.y = @gfx.canvas.height - y
#    onmousedown: (x, y) ->
#      @players.push(new Player([x,window.innerHeight - y], "Frank", "blue"))
    ontouchstart: (x, y) ->
      @cursor.x = x
      @cursor.y = @gfx.canvas.height - y
#      @players.push(new Player([x,window.innerHeight - y], "Frank", "blue"))
    onstep: (delta) ->
      @cursor.rotation += 0.05
    onrender: ->
      game.draw(@gfx)
    onkeydown: (key) ->
      if key is "r"
        location.reload()
    onkeyup: (key) ->
      console.log()

    start: ->
      console.log "initializing the canvas"
      gameCanvas = $('#game_canvas')[0]
      gameCanvas.width = window.innerWidth
      gameCanvas.height = window.innerHeight - 45
      @gfx = cq($('#game_canvas')[0]).framework(this, this)
      @gfx.canvas.getContext("2d").translate(0, @gfx.canvas.height)
      @gfx.canvas.getContext("2d").scale(1, -1)

      @players = [new Player(1, "Alfred", "red", AI), new Player(2, "Frank", "blue")]
  console.log "done"
  return game