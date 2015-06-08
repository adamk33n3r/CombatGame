'use strict'

angular.module 'combatGameApp'
.factory 'Player', ->
  class
    constructor: (@num, @name, @color, @gfx) ->
      @loc = {}
      @box =
        w: 100
        h: 100
      @direction = 1
      if num == 1
        console.log "Loading Player 1..."
        @loc.x = window.innerWidth/4 + 110
        @loc.y = window.innerHeight - @box.h/2 - 2
      else if num == 2
        console.log "Loading Player 2..."
        @loc.x = window.innerWidth/4
        @loc.y = window.innerHeight/4
        @direction = -1

      @arm = 10
      @attacking = false
      @hp = 75

      @gfx.position.set @loc.x, @loc.y

    draw: ->
      @gfx.scale.set @direction, 1
      # gfx.translate(@loc.x, @loc.y)
      @gfx.lineStyle 2, 0xFFFFFF, 1
        # Create clip to hold in HP Bar
        # .save()
        # .roundRect(-@box.w/2, -@box.h + 15, 100, 20, 10)
        # .clip()

        # HP Bar
        .beginFill 0xFF0000
        .drawRoundedRect -@box.w/2, -@box.h + 15, 100, 20, 9.5
        .endFill()
        .beginFill 0x00FF00
        .drawRoundedRect -@box.w/2, -@box.h + 15, @hp, 20, 9.5
        .endFill()
        .drawRoundedRect -@box.w/2, -@box.h + 15, 100, 20, 9.5

        # Body
        .beginFill @color

        # Arm
        .drawRect @arm, -25, 50, 20
        .endFill()

        # Torso
        .beginFill @color
        .drawRoundedRect -@box.w/2, -@box.h/2, @box.w, @box.h
        .endFill()
