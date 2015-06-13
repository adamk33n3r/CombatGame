'use strict'

angular.module 'combatGameApp'
.factory 'Player', (Part) ->
  class
    constructor: (@name, @color, @stage) ->
      @position =
        x: 0
        y: 0
      @box =
        w: 100
        h: 100
      @direction = 1

      @arm = 0
      @hp = 100

      @gfx = new PIXI.Graphics()
      @stage.addChild @gfx
      @mask = new PIXI.Graphics()
      @stage.addChild @mask
      @gfx.mask = @mask
      @gfx.position.set @position.x, @position.y
      @mask.position.set @position.x, @position.y

      # TODO: Of course....make these classes...heh
      @parts =
        arm: new (class extends Part
          constructor: (stage, @color) ->
            super stage, 50, 20
            @length = 20
          render: ->
            super()
            @gfx.lineStyle 2, 0xFFFFFF, 1
            @gfx.beginFill @color
              .drawRoundedRect @length, -25, @box.w, @box.h, 5
              .endFill()
            @gfx.beginFill @color
              .drawRoundedRect @length-75, -25, @box.w, @box.h, 5
              .endFill()
          )(@stage, @color)
        legs: new (class extends Part
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
            super()
            @gfx.position.set @position.x+20, @position.y + @height
            @gfx2.position.set @position.x-20, @position.y + @height
            @gfx.rotation = @langle
            @gfx2.rotation = @rangle
          render: ->
            super()
            @gfx2.clear()
            @gfx.lineStyle 2, 0xFFFFFF, 1
            @gfx.beginFill @color
              .drawRoundedRect 0, 0, @box.w, @box.h, 5
              .endFill()
            @gfx2.lineStyle 2, 0xFFFFFF, 1
            @gfx2.beginFill @color
              .drawRoundedRect 0, 0, @box.w, @box.h, 5
              .endFill()
          )(@stage, @color)
        body: new (class extends Part
          constructor: (stage, @color) ->
            super stage, 100, 100
          render: ->
            super()
            @gfx.lineStyle 2, 0xFFFFFF, 1
            @gfx.beginFill @color
              .drawRoundedRect -@box.w/2, -@box.h/2, @box.w, @box.h, 20
              .endFill()
          )(@stage, @color)
        head: new (class extends Part
          constructor: (stage, @color) ->
            super stage, 150, 150
            @eyeSize = 30
            @eyeHeight = -10-@eyeSize
            @mouthSize = 50
            @mouthHeight = 20
          update: ->
            @gfx.position.set @position.x, @position.y - 100
          render: ->
            super()
            @gfx.lineStyle 2, 0xFFFFFF, 1
            @gfx.beginFill @color
              .drawRoundedRect -@box.w/2, -90, @box.w, @box.h, 20
              .endFill()
            # Eyes
            @gfx.beginFill 0x000000
              .drawRoundedRect -@eyeSize-@eyeSize/2, @eyeHeight, @eyeSize, @eyeSize, 1
              .endFill()
            @gfx.beginFill 0x000000
              .drawRoundedRect @eyeSize-@eyeSize/2, @eyeHeight, @eyeSize, @eyeSize, 1
              .endFill()
            # Mouth
            @gfx.beginFill 0x000000
              .drawRoundedRect -@mouthSize/2, @mouthHeight, @mouthSize, 20, 1
          )(@stage, @color)
        healthbar: new (class extends Part
          constructor: (stage) ->
            super stage, 100, 10, true
            @hp = 35
            @height = -@box.h + 15 - 150
          render: ->
            super()
            @mask.lineStyle 2, 0xFF0000, 1
              .beginFill 0xFF0000
              .drawRoundedRect -@box.w/2-1, @height-1, 102, 22, 9.5
              .endFill()
            @gfx.lineStyle 2, 0xFFFFFF, 1
              .beginFill 0xFF0000
              .drawRoundedRect -@box.w/2, @height, 100, 20, 9.5
              .endFill()
              .beginFill 0x00FF00
              .drawRoundedRect -@box.w/2, @height, @hp, 20, 9.5
              .endFill()
          )(@stage)

    setPosition: (pos) ->
      for _, part of @parts
        part.position.x = pos.x
        # Temporary
        if _ == "healthbar"
          part.position.y = pos.y - 90
        else
          part.position.y = pos.y

    render: ->
      for _, part of @parts
        part.update()
        part.render()
        # Body mask
        # .beginFill @color
        # .drawRect @arm-1, -25-1, 50+2, 20+2
        # .endFill()
        # .beginFill @color
        # .drawRoundedRect -@box.w/2-1, -@box.h/2-1, @box.w+2, @box.h+2
        # .endFill()
      # @gfx.position.set @position.x, @position.y
      # @gfx.clear()
      # @gfx.scale.set @direction, 1
      # gfx.translate(@position.x, @position.y)

        # HP Bar

        # Body
        # .beginFill @color

        # Arm
        # .drawRect @arm, -25, 50, 20
        # .endFill()

        # Torso
        # .beginFill @color
        # .drawRoundedRect -@box.w/2, -@box.h/2, @box.w, @box.h
        # .endFill()
    render2: ->
      @mask.position.set @position.x, @position.y
      @mask.clear()
      # Health mask. Should probs just make health a separate gfx obj
      @mask.beginFill 0xFF0000
        .drawRoundedRect -@box.w/2-1, -@box.h + 15-1, 102, 22, 9.5
        .endFill()
        # # Body mask
        # .beginFill @color
        # .drawRect @arm-1, -25-1, 50+2, 20+2
        # .endFill()
        # .beginFill @color
        # .drawRoundedRect -@box.w/2-1, -@box.h/2-1, @box.w+2, @box.h+2
        # .endFill()
      @gfx.position.set @position.x, @position.y
      @gfx.clear()
      @gfx.scale.set @direction, 1
      # gfx.translate(@position.x, @position.y)
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
