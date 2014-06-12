# Player.js
# by Adam Keenan

console.log "loading Player.js"

Player = Class.extend
  hp: 100
  loc:
    x: 0
    y: 0
  velocity:
    x: 0
    y: 0
  init: ->
    console.log "yelp"
  play: ->
    console.log "helpppp"
  jump: ->
    #@velocity.y += 10
    @velocity.y = 10 if @velocity.y > 10
  move_left: ->
    @velocity.x -= 10 if @velocity >= -20
  move_right: ->
    @velocity.x += 10 if @velocity <= 20

new Player().play()

console.log "done loading Player.js"