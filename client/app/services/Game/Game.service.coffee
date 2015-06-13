'use strict'

angular.module 'combatGameApp'
.service 'Game', (Player, Cursor, zip) ->
  class
    constructor: (@log) ->
      @players = []
      @ts = 0
      @dir = 1
      @lastTime = new Date
      @frameTime = 0
      @setup()

    update: ->
      thisFrameTime = (thisTime = new Date) - @lastTime
      @frameTime += (thisFrameTime - @frameTime) / 20
      @lastTime = thisTime
      @fps = 1000 // @frameTime

      @cursor.update()

    updatePlayers: ->
      zipped = zip(@log.players, @players)
      for item in zipped
        playerLog = item[0].log[@ts].info
        playerGFX = item[1]
        playerGFX.setPosition playerLog.pos
        # playerGFX.setPosition
        #   x: 300
        #   y: 300
        playerGFX.parts.healthbar.hp = playerLog.health
        playerGFX.parts.arm.length = playerLog.arm
        playerGFX.parts.legs.langle = playerLog.legs.left-.3
        playerGFX.parts.legs.rangle = playerLog.legs.right+.3

      if @ts == @log.length - 1
        @dir = -1
      else if @ts == 0
        @dir = 1
      @ts+=@dir
      # if @ts < @log.length - 1
      #   @ts++
      # else
      #   @ts = 0
      @tsText.text = "TS: #{@ts}"

    render: ->

      # Clear screen
      @gfx.clear()

      for player in @players
        player.render()

      @cursor.render()

      @gfx.beginFill 0xFFD900
      @gfx.drawRoundedRect @boxx,@boxy,100,50
      @gfx.endFill()
      @gfx.beginFill 0xFFFFFF
      # @gfx.drawRect @cursor.position.x, @cursor.position.y, 16, 50
      @gfx.endFill()
      @renderer.render @stage

    mainLoop: =>
      @update()
      @render()
      # requestAnimationFrame @mainLoop
      window.setTimeout @mainLoop, 1

    setup: ->
      @boxx=350
      @boxy=350
      canvas = $('canvas#game')[0]
      @renderer = PIXI.autoDetectRenderer window.innerWidth, window.innerHeight,
        view: canvas
        antialias: true
      @renderer.backgroundColor = 0xbbbbbb
      $(window).resize =>
        @renderer.resize window.innerWidth, window.innerHeight

      @stage = new PIXI.Container()
      @stage.interactive = true

      @gfx = new PIXI.Graphics()
      # @gfx.lineStyle 4, 0xFFD900, 1
      @gfx.beginFill 0x0066CC
      @gfx.drawRoundedRect 150, 150, 300, 150
      @gfx.endFill()

      @stage.addChild @gfx

      for playerNum in [1..@log.players.length]
        playerInfo = @log.players[playerNum-1]
        @players.push new Player playerInfo.name, playerInfo.color, @stage

      @fpsText = new PIXI.Text "FPS: ",
        fill: '#00FF00'
      @fpsText.x = 10
      @fpsText.y = 10

      @tsText = new PIXI.Text "TS: ",
        fill: "#00FF00"
      @tsText.x = 10
      @tsText.y = 40

      @stage.addChild @fpsText
      @stage.addChild @tsText

      # Needs to be last added to stage
      @cursor = new Cursor @stage

      document.onmousemove = (e) =>
        @cursor.setPos e.pageX, e.pageY

      setInterval =>
        @fpsText.text = "FPS: #{@fps}"
      , 1000
      setInterval =>
        @updatePlayers()
      , 1000/60
      @mainLoop()

    @singleton = null
    @start: (log) ->
      @singleton = new this(log) if !@singleton?
