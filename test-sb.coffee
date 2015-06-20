fs = require 'fs'
vm = require 'vm'

class Player
  constructor: (@x, @y) ->
    @dx = 0
    @dy = 0
    @wait = 0
    @gravity = 1
    @jumps = 1
    @maxJumps = 1
    @jumpSpeed = 20

    @drag = 2
    @accelPerCall = 5
    @maxAccel = 20
    @moved = false

    @attacking = false
    @canAttack = true
    @attackLength = 10
    @msg = ""
    @arm = 0
    @health = 100

  update: ->
    if @dx > 0
      @dx -= @drag
    else if @dx < 0
      @dx += @drag
    @x += @dx

    if @x < 0
      @x = 0
    else if @x > 1200
      @x = 1200

    @dy -= @gravity
    @y += @dy
    if @y < 0
      @y = 0
      @dy = 0
      @jumps = 0

    if @arm >= 20
      @attacking = false
      @arm = 20
    if @attacking and @arm < 20
      @arm+=3
    else if not @attacking and @arm > 0
      @arm-=1
    if not @canAttack and @arm <= 0
      @canAttack = true
      @arm = 0

  resetState: ->
    @moved = false
    @msg = ""

  #################
  # API Functions #
  #################
  jump: =>
    return if Math.round(@y) is not 0
    if @jumps < @maxJumps
      @jumps++
      @dy = @jumpSpeed

  move: (dir) =>
    return if @moved
    dir = dir.toLowerCase()
    switch dir
      when 'right'
        @dx += if @dx < @maxAccel then @accelPerCall else 0
        @moved = true
      when 'left'
        @dx -= if @dx > -@maxAccel then @accelPerCall else 0
        @moved = true

  attack: =>
    return if @attacking or not @canAttack
    @attacking = true
    @canAttack = false

  say: (@msg) =>

  getExposedFunctions: ->
    {
      @jump
      @move
      @attack
      @say
    }

  getData: ->
    {
      @x
      @y
      @attacking
      @jumps
      @maxJumps
    }

createAPI = (player) ->
    {
      api: player.getExposedFunctions()
      state:
        me:
          x: 0
          y: 200
        other:
          x: 1000
          y: 0
    }

p1 = new Player 100, 0
api1 = createAPI p1
p2 = new Player 1000, 0
api2 = createAPI p2

filename1 = './ai-test.js'
code1 = fs.readFileSync filename1, 'utf8'
code1 = "'use strict';\n" + code1

script1 = new vm.Script code1,
  filename: filename1

filename2 = './ai-test2.js'
code2 = fs.readFileSync filename2, 'utf8'
code2 = "'use strict';\n" + code2
script2 = new vm.Script code2,
  filename: filename2

length = 1000
out =
  date: new Date
  length: length
  players: [
    name: "Player 1"
    color: Math.round Math.random()*0xFFFFFF
    log: [
    ]
  ,
    name: "Player 2"
    color: Math.round Math.random()*0xFFFFFF
    log: [
    ]
  ]

createTS = (health, x, y, arm, say = "") ->
  info:
    health: health
    pos:
      x: x
      y: y
    arm: arm
    legs:
      left: 0
      right: 0
    say: say

# Simulate battle
# for i in [0...length]
i = 0
lastHit = 0
while i - lastHit < 1000 # quit if you haven't gotten hit in 1000 ticks
  script1.runInNewContext api1
  script2.runInNewContext api2
  p1.update()
  p2.update()

  if Math.abs(p1.x - p2.x) < 100 and Math.abs(p1.y - p2.y) < 100 #touching?
    if p1.attacking
      p2.health--
      lastHit = i
    if p2.attacking
      p1.health--
      lastHit = i
  if p1.health <= 0 or p2.health <= 0
    break

  # console.error "p1.x: #{p1.x},\tp1.dx: #{p1.dx}"
  api1.state.me.x = p1.x
  api1.state.me.y = p1.y
  api1.state.other.x = p2.x
  api1.state.other.y = p2.y
  api2.state.me.x = p2.x
  api2.state.me.y = p2.y
  api2.state.other.x = p1.x
  api2.state.other.y = p1.y
  out.players[0].log.push createTS p1.health, p1.x, p1.y, p1.arm, p1.msg
  out.players[1].log.push createTS p2.health, p2.x, p2.y, p2.arm, p2.msg
  p1.resetState()
  p2.resetState()

  i++

out.length = i

console.log JSON.stringify out
