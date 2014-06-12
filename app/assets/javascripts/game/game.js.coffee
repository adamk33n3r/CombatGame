define ['game/Player'], (Player) ->
  console.log "loading game.js.coffee"
  game = {

    player: {
      x:0
      y:0
      rotation:0
    }
    circle: new Player(window.innerWidth/2,window.innerHeight/2)
    draw: (gfx) ->
      @update()
      gfx.fillStyle "#FF0000"
      gfx.clear("#000000")
      gfx.save()
        .translate(@player.x,@player.y)
        .rotate(@player.rotation)
        .fillStyle("#FF0000")
        .fillRect(-50/2, -50/2, 50, 50)
        .restore()
      gfx.fillStyle "#00FF00"
      gfx.strokeStyle "blue"

      gfx.circle(@circle.loc.x,@circle.loc.y,50).fill().stroke()
#      console.log "finished drawing"
    update: ->
        @circle.loc.y -= @circle.velocity.y
        @circle.loc.y = 0 if @circle.loc.y < 0
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
      @player.x = x
      @player.y = @gfx.canvas.height - y
    onstep: (delta) ->
      @player.rotation += 0.05
    onrender: ->
      game.draw(@gfx)
    onkeydown: (key) ->
      console.log "key pressed: #{key}"
      if key is "right"
        @circle.loc.x += 10
        console.log @circle.loc.x
      else if key is "left"
        @circle.loc.x -= 10
      else if key is "up"
        @circle.loc.y += 10
      else if key is "down"
        @circle.loc.y -= 10
      else if key is "space"
        @circle.jump()

    start: ->
      console.log "initializing the canvas"
      gameCanvas = $('#game_canvas')[0]
      gameCanvas.width = window.innerWidth
      gameCanvas.height = window.innerHeight - 45
      @gfx = cq($('#game_canvas')[0]).framework(this, this)
      @gfx.canvas.getContext("2d").translate(0, @gfx.canvas.height)
      @gfx.canvas.getContext("2d").scale(1, -1)
  }
  console.log "done"
  return game