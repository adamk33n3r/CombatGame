'use strict'

describe 'Service: AI', ->

  # load the service's module
  beforeEach module 'combatGameApp'

  # instantiate service
  AI = undefined
  beforeEach inject (_AI_) ->
    AI = _AI_

  it 'should do something', ->
    expect(!!AI).toBe true
