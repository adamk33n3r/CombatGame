'use strict'

angular.module 'combatGameApp'
.service 'Game', class
  constructor: (@Player, @AI) ->

    @GAMESTATE =
      cursor:
        pos:
          x: 0
          y: 0
        rotation: 0
      players: null
      create: ->
        layer = @app.layer
        layer.canvas.style.cursor = 'none'
        #layer.context.translate(0, @app.height)
        #layer.context.scale(1, -1)
      render: ->
        layer = @app.layer

        # Clear screen
        layer.clear("#000000")

        @update()
        #for player in @players
        #  player.draw(layer)

        # Draws cursor
        # Log
        layer.save()
          .translate(@cursor.pos.x, @cursor.pos.y)
          .rotate(-45 * Math.PI / 180)
          .fillStyle("white")
          .fillRect(-8,0,16,50)
          .restore()
        # Big square
        layer.save()
          .translate(@cursor.pos.x,@cursor.pos.y)
          .rotate(@cursor.rotation)
          .fillStyle("darkgrey")
          .fillRect(-30/2, -30/2, 30, 30)
          .restore()
        # Small square
        layer.save()
          .translate(@cursor.pos.x,@cursor.pos.y)
          .rotate(-@cursor.rotation)
          .fillStyle("grey")
          .fillRect(-16/2, -16/2, 16, 16)
          .restore()
      update: ->

      check_for_contact: ->
        p1 = @players[0]
        p2 = @players[1]
        arm_x_pos = p1.loc.x + ( p1.box.w / 2 + p1.arm ) * p1.direction
        return arm_x_pos > p2.loc.x - p2.box.w/2 and arm_x_pos < p2.loc.x + p2.box.w/2

      mousemove: (pos) ->
        # save mouse x, y
        @cursor.pos = pos
        #@cursor.pos.y = @app.height - pos.y
        #@cursor.y = @app.height - y
      touchmove: (x, y) ->
        # save mouse x, y
        @cursor.x = x
        @cursor.y = @app.height - y
    #    mousedown: (x, y) ->
    #      @players.push(new Player([x,window.innerHeight - y], "Frank", "blue"))
      touchstart: (x, y) ->
        @cursor.x = x
        @cursor.y = @app.height - y
    #      @players.push(new Player([x,window.innerHeight - y], "Frank", "blue"))
      step: (delta) ->
        @cursor.rotation += 0.05
      keydown: (key) ->
        if key is "r"
          location.reload()
      keyup: (key) ->
        console.log()

  start: ->
    game = this

    app = playground
      smoothing: false
      container: '#game_area'
      ready: ->
        console.log "setting to gamestate"
        @setState game.GAMESTATE
    console.log app

