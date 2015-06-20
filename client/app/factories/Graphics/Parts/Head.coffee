'use strict'

angular.module 'combatGameApp'
.factory 'PartHead', (Part) ->
  class extends Part
    constructor: (stage, @color) ->
      super stage, 150, 150
      @eyeSize = 30
      @eyeHeight = -10-@eyeSize
      @mouthSize = 50
      @mouthHeight = 20
    update: ->
      @gfx.position.set @position.x, @position.y - 100
    render: ->
      super
      @gfx.lineStyle 2, 0xFFFFFF, 1
      @gfx.beginFill @color
        .drawRoundedRect -@box.w/2, -90, @box.w, @box.h, 20
        .endFill()
      # Eyes
      @gfx.beginFill 0x000000
        .drawRoundedRect -@eyeSize-@eyeSize/2, @eyeHeight, @eyeSize, @eyeSize, 1
        .drawRoundedRect @eyeSize-@eyeSize/2, @eyeHeight, @eyeSize, @eyeSize, 1
      # Mouth
        .drawRoundedRect -@mouthSize/2, @mouthHeight, @mouthSize, 20, 1
        .endFill()
