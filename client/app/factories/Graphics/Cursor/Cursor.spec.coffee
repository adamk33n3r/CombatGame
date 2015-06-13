'use strict'

describe 'Service: Cursor', ->

  # load the service's module
  beforeEach module 'combatGameApp'

  # instantiate service
  Cursor = undefined
  beforeEach inject (_Cursor_) ->
    Cursor = _Cursor_

  it 'should do something', ->
    expect(!!Cursor).toBe true