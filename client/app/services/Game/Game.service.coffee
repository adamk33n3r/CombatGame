'use strict'

angular.module 'combatGameApp'
.service 'Game', class
  constructor: (@Player, @Cursor, @zip) ->
    @cursor =
      pos:
        x: 0
        y: 0
      rotation: 0
    @cursor =
    @players = []
    @ts = 0
    @lastTime = new Date
    @frameTime = 0

  update: ->
    thisFrameTime = (thisTime = new Date) - @lastTime
    @frameTime += (thisFrameTime - @frameTime) / 20
    @lastTime = thisTime
    @fps = 1000 // @frameTime

    @cursor.update()

    if @ts < @log.length
      zipped = @zip(@log.players, @players)
      for item in zipped
        playerLog = item[0].log[@ts].info
        playerGFX = item[1]
        playerGFX.hp = playerLog.health
        playerGFX.position.x = playerLog.pos.x
        playerGFX.position.y = playerLog.pos.y
        # set info of correct player
      if @ts is 0
        @ts++
      else
        @ts--

  render: ->

    # Clear screen
    @gfx.clear()

    for player in @players
      player.draw()

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
    requestAnimationFrame @mainLoop

  start: (@log) ->
    @boxx=350
    @boxy=350
    canvas = $('canvas#game')[0]
    @renderer = PIXI.autoDetectRenderer window.innerWidth, window.innerHeight,
      view: canvas
      antialias: true
    @renderer.backgroundColor = 0xbbbbbb

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
      gfx = new PIXI.Graphics()
      @stage.addChild gfx
      @players.push new @Player playerNum, playerInfo.name, playerInfo.color, gfx

    @fpsText = new PIXI.Text "FPS: ",
      fill: '#00FF00'
    @fpsText.x = 30
    @fpsText.y = 90

    @stage.addChild @fpsText

    # Needs to be last added to stage
    @cursor = new @Cursor @stage

    document.onmousemove = (e) =>
      @cursor.setPos e.pageX, e.pageY

    setInterval =>
      @fpsText.text = "FPS: #{@fps}"
    , 1000
    @mainLoop()
