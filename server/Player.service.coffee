'use strict'

angular.module 'combatGameApp'
.service 'Player', ->
  # AngularJS will instantiate a singleton by calling 'new' on this function
  class default_ai
    constructor: (player, opponent) ->
      @player = player
      @opponent = opponent
      @creator = "default"
    act: ->
#      @player.jump()
      @player.punch()
      if @opponent.x - @player.box.w / 2 - 50 > @player.loc.x
        @player.turnRight()
      else if @opponent.x + @player.box.w / 2 < @player.loc.x
        @player.turnLeft()
      @player.moveForward()
#      @player.takeDamage(.1)

  class
#    name: "Player"
#    color: "red"
#    hp: 100
#    loc:
#      x: 0
#      y: 0
#    velocity:
#      x: 0
#      y: 0
#    box:
#      w: 0
#      h: 0
#    ai: null
    constructor: (num, name, color, ai) ->
      console.log "Player init"
      @loc = {}
      @opponent = null
      @direction = 1
      if num == 1
        console.log "Loading Player 1..."
        @loc.x = window.innerWidth/4 + 110
        @loc.y = window.innerHeight/4
      else if num == 2
        console.log "Loading Player 2..."
        @loc.x = window.innerWidth/4
        @loc.y = window.innerHeight/4
        # @direction = -1
#        @loc.x = window.innerWidth/4*3
#        @loc.y = window.innerHeight/4*3
      else
        @loc.x = num[0]
        @loc.y = num[1]
      @velocity =
        x: 0
        y: 0
      @box = {}
      @box.w = 100
      @box.h = 100
      @num = num
      @name = name
      @color = color

      @arm = 0
      @attacking = false
      @hp = 100
      @alive = true





    act: ->
      # Ask the AI to do something
      #@ai.act()

    # CONTROLS
    jump: ->
      if @loc.y == window.innerHeight - @box.h/2
        @velocity.y = -10
    moveForward: ->
      @velocity.x += @direction
      if Math.abs(@velocity.x) > 5
        @velocity.x = if @velocity.x < 0 then -5 else 5
    moveBackward: ->
      @velocity.x -= @direction if Math.abs(@velocity.x) < 1
    punch: ->
      @attacking = true if @arm == 0
#      @arm = 20 if @arm == 0
    turnRight: ->
      @direction = 1
    turnLeft: ->
      @direction = -1

    # TOOLS
    takeDamage: (amt) ->
      @hp -= amt
      @hp = 0 if @hp < 0
      @hp = 100 if @hp > 100

    disable: ->
      @alive = false

    # UPDATE AND DRAW
    update: ->
#      console.log "#{@name}: #{@velocity.x}"
      return if !@alive
#      console.log "name: #{@name}, loc: "
#      console.log @loc
      @loc.y += @velocity.y
      if @loc.y > window.innerHeight - @box.h/2 # Is under ground
        @loc.y = -@box.h/2 + window.innerHeight
        @velocity.y = 0
      else
        @velocity.y += 1
      @loc.x += @velocity.x
      if @loc.x < 0
        @loc.x = 0
        @velocity.x = 0
      else if @loc.x > window.innerWidth
        @loc.x = window.innerWidth
        @velocity.x = 0
      if @velocity.x < 0
        @velocity.x += .1
      else if @velocity.x > 0
        @velocity.x -= .1

      @attacking = false if @arm == 20
      @arm++ if @attacking && @arm < 20
      @arm-- if !@attacking && @arm > 0

    draw: (gfx) ->
      gfx.save()
        .translate(@loc.x, @loc.y)
        .strokeStyle "white"

        # Create clip to hold in HP Bar
        .save()
        .roundRect(-@box.w/2, -@box.h + 15, 100, 20, 10)
        .clip()
        # HP Bar
        .fillStyle "red"
        .roundRect(-@box.w/2, -@box.h + 15, 100, 20, 10).fill()
#        .roundRect(-@box.w/2 + @hp, @box.h - 30, 100 - @hp, 20)
        .fillStyle "green"
        .roundRect(-@box.w/2, -@box.h + 15, @hp, 20, 10).fill()
        .restore()
        .save()
        .lineWidth(2)
        .roundRect(-@box.w/2, -@box.h + 15, 100, 20, 10).stroke()
        .restore()

        # Body
        .scale(@direction, 1)
        .fillStyle @color
        # Arm
        .fillRect(@arm, -25, 50, 20)
        .strokeRect(@arm, -25, 50, 20)
        # Torso
#        .circle(0,0,50).fill().stroke()
        .fillRect(-@box.w/2, -@box.h/2, @box.w, @box.h)
        .strokeRect(-@box.w/2, -@box.h/2, @box.w, @box.h)
#      gfx.context.drawImage($("img")[0], @loc.x, @loc.y)
        .restore()
    setUp: (ai, opponent) ->
      @opponent = opponent
      @ai = if ai then new ai(this, @opponent) else new default_ai(this, @opponent)
      console.log("#{@color} player by #{@ai.creator} x: #{@loc.x}, y: #{@loc.y}")
