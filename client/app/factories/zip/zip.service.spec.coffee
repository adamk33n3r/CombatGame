'use strict'

describe 'Service: zip', ->

  # load the service's module
  beforeEach module 'combatGameApp'

  # instantiate service
  zip = undefined
  beforeEach inject (_zip_) ->
    zip = _zip_

  it 'should do something', ->
    expect(!!zip).toBe true