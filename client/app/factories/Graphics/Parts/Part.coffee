'use strict'

angular.module 'combatGameApp'
.factory 'Part', ->
  class
    constructor: (@stage, w = 100, h = 100, useMask = false) ->
      @position = {}
      @box = {
        w, h
      }
      @gfx = new PIXI.Graphics()
      @gfx.position.set @position.x, @position.y
      @stage.addChild @gfx
      if useMask
        @mask = new PIXI.Graphics()
        @mask.position.set @position.x, @position.y
        @stage.addChild @mask
        @gfx.mask = @mask

    update: ->
      @mask?.position.set @position.x, @position.y
      @gfx.position.set @position.x, @position.y

    render: ->
      @mask?.clear()
      @gfx.clear()
