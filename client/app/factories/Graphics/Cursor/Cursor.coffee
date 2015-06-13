'use strict'

angular.module 'combatGameApp'
.factory 'Cursor', ->
  class
    constructor: (@stage) ->
      @log = new PIXI.Graphics()
      @log.rotation = -35 * Math.PI / 180
      @big = new PIXI.Graphics()
      @small = new PIXI.Graphics()
      @stage.addChild @log
      @stage.addChild @big
      @stage.addChild @small


      @position =
        x: -50
        y: -50
      @rotation = 0

    setPos: (x, y) ->
      @position.x = x
      @position.y = y

    update: ->
      @log.position = @position
      @big.position = @position
      @small.position = @position

      @big.rotation+=.05
      @small.rotation-=.05

    render: ->
      @log.clear()
      @big.clear()
      @small.clear()

      @log.beginFill 0xFFFFFF
      @log.drawRect -8, 0, 16, 50
      @log.endFill()

      @big.beginFill 0x444444
      @big.drawRect -30/2, -30/2, 30, 30
      @big.endFill()

      @small.beginFill 0x888888
      @small.drawRect -16/2, -16/2, 16, 16
      @small.endFill()
