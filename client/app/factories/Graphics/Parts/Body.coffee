'use strict'

angular.module 'combatGameApp'
.factory 'PartBody', (Part) ->
  class extends Part
    constructor: (stage, @color) ->
      super stage, 100, 100
    render: ->
      super
      @gfx.lineStyle 2, 0xFFFFFF, 1
      @gfx.beginFill @color
        .drawRoundedRect -@box.w/2, -@box.h/2, @box.w, @box.h, 20
        .endFill()
