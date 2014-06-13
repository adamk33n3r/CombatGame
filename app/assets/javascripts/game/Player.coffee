# Player.js
# by Adam Keenan
#$(".static.game").ready ->

define ['./Class'], (Class) ->
  console.log "loading Player.js"

  default_ai = Class.extend
    init: (player) ->
      @player = player
      @creator = "default"
    act: ->
      @player.jump()
      @player.punch()

  Player = Class.extend
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
    init: (num, name, color, ai) ->
      console.log "Player init"
      @loc = {}
      if num == 1
        console.log "Loading Player 1..."
        @loc.x = window.innerWidth/4
        @loc.y = window.innerHeight/4
      else if num == 2
        console.log "Loading Player 2..."
        @loc.x = window.innerWidth/4*3
        @loc.y = window.innerHeight/4*3
      else
        @loc.x = num[0]
        @loc.y = num[1]
      @velocity =
        x: 0
        y: 0
      @box = {}
      @box.w = 100
      @box.h = 100
      @name = name
      @color = color

      @arm = 0
      @direction = 1
      @attacking = false




      @ai = ai || new default_ai()
      @ai.init(this)
      console.log("#{@color} player by #{@ai.creator} x: #{@loc.x}, y: #{@loc.y}")
    act: ->
      # Ask the AI to do something
      @ai.act()

    # CONTROLS
    jump: ->
      if @loc.y == @box.h/2
        @velocity.y = -10
    move_left: ->
      @direction = -1
      @velocity.x -= 1 if @velocity.x >= -5
    move_right: ->
      @direction = 1
      @velocity.x += 1 if @velocity.x <= 5
    punch: ->
      @arm = 10 if @arm == 0
    turn: ->
      @direction = if @direction == 1 then -1 else 1

    # UPDATE AND DRAW
    update: ->
#      console.log "name: #{@name}, loc: "
#      console.log @loc
      @loc.y -= @velocity.y
      if @loc.y - @box.h/2 < 0
        @loc.y = @box.h/2
        @velocity.y = 0
      else
        @velocity.y += 1
      @loc.x += @velocity.x
      if @velocity.x < 0
        @velocity.x += .1
      else if @velocity.x > 0
        @velocity.x -= .1

      @arm-- if @arm > 0
    draw: (gfx) ->
      gfx.save()
        .translate(@loc.x, @loc.y)
        .scale(@direction, 1)
        .fillStyle @color
        .strokeStyle "white"
        .fillRect(@arm, 25, 50, 20)
        .circle(0,0,50).fill().stroke()
#      gfx.context.drawImage($("img")[0], @loc.x, @loc.y)
        .restore()



  console.log "done loading Player.js"
  return Player