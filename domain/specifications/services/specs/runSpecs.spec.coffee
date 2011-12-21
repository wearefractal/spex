#>> Setup

_ = require('slice') __dirname

Spec           = _.load 'specifications.Spec'
Scenario       = _.load 'scenarios.Scenario'
runSpecs        = _.load 'specifications.runSpecs'

#>> Given some Specs

specs = []

code =
  '''
  #>> Given foo
    foo = 'foo'
  #>> When I change the value of foo
    foo = 'bar'
  #>> Then
    foo.should.equal 'bar'
  '''

specs.push mySpec = new Spec 
  name: 'assignment test'
  specDSL: code
  isCoffee: true

code2 =
  '''
  #>> Given baz
    baz = 'baz'
  #>> When I change the value of baz
    baz = 'bar'
  #>> Then
    baz.shosuld.equal 'bar'
  '''

specs.push mySpec2 = new Spec 
  name: 'assignment test2'
  specDSL: code2
  isCoffee: true

#>> When I run the specs


runSpecs specs, (specs) ->

  specs[0].name.should.equal "assignment test"
  specs[0].status.should.equal 'pass'

  specs[1].name.should.equal "assignment test2"
  specs[1].status.should.equal 'fail'
  

