#>> Setup

_ = require('slice') __dirname

Spec           = _.load 'specifications.Spec'
Scenario       = _.load 'scenarios.Scenario'
runSpec        = _.load 'specifications.runSpec'

#>> Given a Spec

code =
  '''
  #>> Given foo
    foo = 'foo'
  #>> When I change the value of foo
    setTimeout (->    
      foo = 'bar'
      foo.should.equal 'bar'
    ), 1000
  '''

mySpec = new Spec 
  name: 'assignment test'
  specDSL: code
  isCoffee: true

#>> Then

mySpec.status.should.equal 'notrun'

#>> When I run the spec

runSpec mySpec, (err, spec) ->

#>> Then
    
  spec.status.should.equal 'pass'

