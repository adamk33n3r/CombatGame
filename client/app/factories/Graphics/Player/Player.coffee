'use strict'

angular.module 'combatGameApp'
.factory 'Player', (Part, PartArm, PartBody, PartHealthbar, PartLeg, PartHead) ->
  class
    constructor: (@name, @color, @stage) ->
      # TODO: Should also expiriment with consolidating gfx objects. Things that rotate need new ones, though
      @parts =
        arm: new PartArm @stage, @color
        legs: new PartLeg @stage, @color
        body: new PartBody @stage, @color
        head: new PartHead @stage, @color
        healthbar: new PartHealthbar @stage

    setPosition: (pos) ->
      for _, part of @parts
        part.position.x = pos.x
        # Temporary
        if _ == "healthbar"
          part.position.y = window.innerHeight - pos.y - 190
        else
          part.position.y = window.innerHeight - pos.y - 100

    render: ->
      for _, part of @parts
        part.update()
        part.render()
