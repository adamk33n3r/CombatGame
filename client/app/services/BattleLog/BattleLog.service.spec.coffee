'use strict'

describe 'Service: BattleLog', ->

  # load the service's module
  beforeEach module 'combatGameApp'

  # instantiate service
  BattleLog = undefined
  beforeEach inject (_BattleLog_) ->
    BattleLog = _BattleLog_

  it 'should do something', ->
    expect(!!BattleLog).toBe true
