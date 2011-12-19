#>> Setup

_ = require('slice') __dirname
Spec = _.load 'specifications.Spec'
Scenario = _.load 'scenarios.Scenario'
runSpec = _.load 'specifications.runSpec'

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

mySpec = new Spec 'assignment test', code, true
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
  code: "foo.should.equal 'bar'"
  leadspace: '  '


#>> Then

mySpec.status.should.equal 'notrun'

#>> When I run the spec

runSpec mySpec, (spec) ->

#>> Then
    
  #console.log spec
  spec.status.should.equal 'pass'


