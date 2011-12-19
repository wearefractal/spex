#>> Setup

_ = require('slice') __dirname
should = require 'should'
SpexSandbox = require '../sandbox.agent'
Spec = _.load 'specifications.Spec'
Scenario = _.load 'scenarios.Scenario'

#>> Given a Spec

code =
  '''
  >> Given foo
    foo = 'foo'
  >> When I change the value of foo
    foo = 'bar'
  >> Then
    foo.should.equal 'bar'
  '''

mySpec = new Spec 
  name: 'assignment test'
  specDSL: code
  isCoffee: true

mySpec.scenarios = []
mySpec.scenarios.push new Scenario 
  id: 0
  name: 'Given foo'
  code: 'foo = "foo"'
  leadspace: '  '

mySpec.scenarios.push new Scenario 
  id: 1
  name: 'When I change foo to bar'
  code: 'foo = "bar"'
  leadspace: '  '

mySpec.scenarios.push new Scenario 
  id: 2
  name: 'Then'
  code: 'foo = "bar"'
  leadspace: '  '

#>> When I create a new sandbox

sb = new SpexSandbox mySpec, (spec) ->

#>> Then the space should be passing 

  spec.status.should.equal 'pass'

#>> When I call pass on all scenarios

sb.pass 0
sb.pass 1
sb.pass 2

