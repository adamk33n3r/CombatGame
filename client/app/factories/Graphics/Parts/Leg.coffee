'use strict'

angular.module 'combatGameApp'
.factory 'PartLeg', (Part) ->
  class extends Part
    constructor: (stage, @color) ->
      super stage, 20, 50
      @gfx2 = new PIXI.Graphics()
      @stage.addChild @gfx2
      @height = 35
      @langle = 0
      @rangle = 0
      @gfx.pivot.set @box.w/2, 0
      @gfx2.pivot.set @box.w/2, 0
    update: ->
      super
      @gfx.position.set @position.x+20, @position.y + @height
      @gfx2.position.set @position.x-20, @position.y + @height
      @gfx.rotation = @langle
      @gfx2.rotation = @rangle
    render: ->
      super
      @gfx2.clear()
      @gfx.lineStyle 2, 0xFFFFFF, 1
      @gfx.beginFill @color
        .drawRoundedRect 0, 0, @box.w, @box.h, 5
        .endFill()
      @gfx2.lineStyle 2, 0xFFFFFF, 1
      @gfx2.beginFill @color
        .drawRoundedRect 0, 0, @box.w, @box.h, 5
        .endFill()
