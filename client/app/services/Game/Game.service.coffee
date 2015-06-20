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
      @paused = true
      @t_pos = $('#t_pos')
      @setup()

    update: ->
      thisFrameTime = (thisTime = new Date) - @lastTime
      @frameTime += (thisFrameTime - @frameTime) / 20
      @lastTime = thisTime
      @fps = 1000 // @frameTime

      # @cursor.update()

    updatePlayers: ->
      # return if @paused
      if not @paused and @ts < @log.length and @ts > 0
        @setTS @ts + @dir
      @tsText.text = "TS: #{@ts}"
      pos = @ts/@log.length*100
      offset = pos*24/100
      # @t_pos.css
        # left: "calc(#{pos}% - #{offset}px)"
      if @ts is @log.length
        @paused = true
        # @ts = 1
        return
      zipped = zip(@log.players, @players)
      for item in zipped
        playerLog = item[0].log[@ts].info
        playerGFX = item[1]
        @updatePlayerInfo playerGFX, playerLog

      # if @ts == @log.length - 1
      #   @dir = -1
      # else if @ts == 0
      #   @dir = 1

    updatePlayerInfo: (playerGFX, playerLog) ->
        playerGFX.setPosition playerLog.pos
        # playerGFX.setPosition
        #   x: 300
        #   y: 300
        playerGFX.parts.healthbar.hp = playerLog.health
        playerGFX.parts.arm.length = playerLog.arm
        playerGFX.parts.legs.langle = playerLog.legs.left-.3
        playerGFX.parts.legs.rangle = playerLog.legs.right+.3
        # console.log playerLog.say if playerLog.say and not @paused

    render: ->

      for player in @players
        player.render()

      # @cursor.render()

      @renderer.render @stage

    mainLoop: =>
      @update()
      @render()
      requestAnimationFrame @mainLoop
      # window.setTimeout @mainLoop, 0

    setTS: (@ts, pos) ->
      if not pos?
        pos = @$timeline.width() / @log.length * @ts - @$t_pos.width()/2
        if pos < 3
          pos = 3
        if pos > @$timeline.width() - @$t_pos.width() - 3
          pos = @$timeline.width() - @$t_pos.width()-3
      @$t_pos.position
        my: "left+#{pos}"
        at: 'left'
        of: '#timeline'
      return if @ts is @log.length
      zipped = zip(@log.players, @players)
      for item in zipped
        playerLog = item[0].log[@ts].info
        playerGFX = item[1]
        # @updatePlayerInfo playerGFX, playerLog
        console.log playerLog.say if playerLog.say

    setup: ->
      @$timeline = $('#timeline')
      @$t_pos = $('#t_pos')
      @boxx=350
      @boxy=350
      canvas = $('canvas#game')[0]
      @renderer = PIXI.autoDetectRenderer window.innerWidth, window.innerHeight,
        view: canvas
        antialias: true
      @renderer.backgroundColor = 0xAAAAAA
      $(window).resize =>
        @renderer.resize window.innerWidth, window.innerHeight

      @stage = new PIXI.Container()
      @stage.interactive = true

      for playerNum in [1..@log.players.length]
        playerInfo = @log.players[playerNum-1]
        @players.push new Player playerInfo.name, playerInfo.color, @stage

      @fpsText = new PIXI.Text "FPS: ",
        fill: '#13BA45'
      @fpsText.x = 10
      @fpsText.y = 10

      @tsText = new PIXI.Text "TS: ",
        fill: '#13BA45'
      @tsText.x = 10
      @tsText.y = 40

      @stage.addChild @fpsText
      @stage.addChild @tsText

      zipped = zip(@log.players, @players)
      for item in zipped
        playerLog = item[0].log[@ts].info
        playerGFX = item[1]
        @updatePlayerInfo playerGFX, playerLog

      # Needs to be last added to stage
      # @cursor = new Cursor @stage

      # document.onmousemove = (e) =>
        # @cursor.setPos e.pageX, e.pageY

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
