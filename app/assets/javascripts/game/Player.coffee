# Player.js
# by Adam Keenan
#$(".static.game").ready ->
console.log "poopy"
define ['./Class'], (Class) ->
  console.log "loading Player.js"

  Player = Class.extend
    hp: 100
    loc:
      x: 0
      y: 0
    velocity:
      x: 0
      y: 0
    init: (x, y) ->
      console.log "Player init"
      @loc.x = x
      @loc.y = y
      console.log "x: #{@loc.x}, y: #{@loc.y}"
    play: ->
      console.log "Player play"
    jump: ->
      #@velocity.y += 10
      @velocity.y = 10 if @velocity.y > 10
    move_left: ->
      @velocity.x -= 10 if @velocity >= -20
    move_right: ->
      @velocity.x += 10 if @velocity <= 20
  console.log "done loading Player.js"
  return Player