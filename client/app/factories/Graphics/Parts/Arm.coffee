'use strict'

angular.module 'combatGameApp'
.factory 'PartArm', (Part) ->
  class extends Part
    constructor: (stage, @color) ->
      super stage, 50, 20
      @length = 20
    render: ->
      super
      @gfx.lineStyle 2, 0xFFFFFF, 1
      @gfx.beginFill @color
        .drawRoundedRect @length, -25, @box.w, @box.h, 5
        .endFill()
      @gfx.beginFill @color
        .drawRoundedRect @length-75, -25, @box.w, @box.h, 5
        .endFill()
