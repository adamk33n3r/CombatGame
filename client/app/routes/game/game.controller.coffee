'use strict'

angular.module 'combatGameApp'
.controller 'GameCtrl', ($scope, BattleLog, Game) ->
  $('body').css
    overflow: 'hidden'
  BattleLog.get('test2').then (response) ->
    prevX = 0
    prevY = 0
    # $(document.body).on 'mousemove', (e) ->
    #   if prevX == e.pageX and prevY == e.pageY
    #     return
    #   prevX = e.pageX
    #   prevY = e.pageY
    #   $('#cursor').offset
    #     left: e.pageX - 20
    #     top: e.pageY - 20
    game = Game.start response.data
    $('#pause').click ->
      game.paused = true
    $('#loop').click ->
      game.paused = false
      if game.dir == 1
        game.setTS 1
      else
        game.setTS game.log.length - 1
    $('#forward').click ->
      return if game.ts is game.log.length
      game.paused = false
      game.dir = 1
      game.ts++
    $('#reverse').click ->
      return if game.ts is 0
      game.paused = false
      game.dir = -1
      game.ts--
    $('#step-forward').click ->
      return if game.ts is game.log.length
      game.paused = true
      game.dir = 1
      game.setTS game.ts + 1
    $('#step-backward').click ->
      return if game.ts is 0
      game.paused = true
      game.dir = -1
      game.setTS game.ts - 1
    $('#timeline').mousedown (e) ->
      pos = e.offsetX - $('#t_pos').width()/2
      # If I'm clicking on the slider then add its offset from timeline
      if e.target.id is 't_pos'
        pos += Math.round parseInt e.target.style.left, 10
      ts = Math.round pos / $(this).width() * game.log.length
      if ts < 0
        ts = 0
      if pos < 2
        pos = 2
      game.setTS ts, pos
    $('#t_pos').css
      left: '1px'
    .draggable
      axis: 'x'
      drag: (e, ui) ->
        max = $('#timeline').width() - $(this).width() - 3 # -3 for border and 1px extra
        if ui.position.left < 1
          ui.position.left = 1
        if ui.position.left > max
          ui.position.left = max
        game.ts = Math.round ui.position.left / max * game.log.length
        game.ts = game.log.length - 1 if game.ts >= game.log.length
