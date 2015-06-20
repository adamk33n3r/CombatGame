'use strict'

angular.module 'combatGameApp'
.factory 'PartHealthbar', (Part) ->
  class extends Part
    constructor: (stage) ->
      super stage, 100, 10, true
      @hp = 35
      @height = -@box.h + 15 - 150
      @green = 0x13BA45
      @red = 0xBC2439
    render: ->
      super
      @mask.lineStyle 2, 0xFF0000, 1
        .beginFill @green
        .drawRoundedRect -@box.w/2, @height, 100, 20, 9.5
        .endFill()
      @gfx.lineStyle 2, 0xFFFFFF, 1
        .beginFill @red
        .drawRoundedRect -@box.w/2, @height, 100, 20, 9.5
        .endFill()
        .beginFill @green
        .drawRoundedRect -@box.w/2, @height, @hp, 20, 9.5
        .endFill()
