chai = require 'chai'
chai.should()

describe 'Task instance', ->
  one = data: "some"
  it 'should test data', ->
    one.data.should.equal 'some2'
