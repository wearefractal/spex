#>> Setup

_ = require('slice') __dirname

Spec    = _.load 'specifications.Spec'
runSpec = _.load 'specifications.runSpec'

#>> Given a Spec

code =
  '''
  #>> Given foo
    foo = 'foo'
  #>> When I change the value of foo
    foo = 'bar'
  #>> Then
    foo.should.equal 'bar'
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


