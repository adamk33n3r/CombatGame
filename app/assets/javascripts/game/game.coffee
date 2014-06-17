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
      p1 = @players[0]
      p2 = @players[1]
#      if p1.loc.x + p1.box.w/2 + p1.arm >= p2.loc.x - p2.box.w/2
#        # Player one hit player two from the left
#        console.log "PUAANNCCHHH"
#        p2.takeDamage(10)
      if p1.attacking && @check_for_contact()
        p1.attacking = false
#        p1.arm = 20 # slows down punches. otherwise if 1 unit away, punch every tick
        console.log "PUAANNCCHHH"
        p2.takeDamage(10)
#        debugger
      for player in @players
        if player.hp <= 0
          player.disable()
        player.act()
      return null

    check_for_contact: ->
      # Arm edge x position:
      #   arm_x_pos = x + ( our_width_of_body / 2 + arm_dist_from_body ) * direction
      # Nearest body edge:
      #   x_diff = our_x - their_x
      #   TWO METHODS TO FIND SIDE: depends on if we need to account for zero separately
      #   side = ( x_diff >> 31 ) | ( ( ( ~x_diff + 1 ) >> 31 ) & 1 )
      #     side =  1 when our_x  > their_x
      #     side =  0 when our_x == their_x
      #     side = -1 when our_x  < their_x
      #   side = ( x_diff >> 31 ) & 1
      #     side = 1 when our_x < their_x
      #     side = 0 when our_x >= their_x
      #   their_closest_edge = their_x + their_width_of_body / 2 * side
      p1 = @players[0]
      p2 = @players[1]
      arm_x_pos = p1.loc.x + ( p1.box.w / 2 + p1.arm ) * p1.direction
      x_diff = p1.loc.x - p2.loc.x
      side = ( x_diff >> 31 ) | ( ( ( ~x_diff + 1 ) >> 31 ) & 1 )
      their_edge = p2.loc.x + ( p2.box.w / 2 * side )
#      console.log "#{x_diff}:#{side}:#{arm_x_pos}:#{their_edge}"
      return Math.abs(arm_x_pos - their_edge) < 1


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

      player1 = new Player(1, "Frank", "blue")
      player2 = new Player(2, "Alfred", "red")
      player1.setUp(null, player2.loc)
      player2.setUp(AI, player1.loc)
      @players = [player1, player2]
  console.log "done"
  return game