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
    f = ->
      console.log "running foo..."

  #>> When I change the value of foo

      foo = 'bar'

  #>> Then foo should equal bar

      foo.should.equal 'bar'

  #>> Call the function on a timeout 

    setTimeout f, 1000
  '''


specs.push mySpec = new Spec 
  name: 'async1'
  specDSL: code
  isCoffee: true

code2 =
  '''
  #>> Given foo

    foo = 'foo'
    f = ->
      console.log "running bar..."

  #>> When I change the value of foo

      foo = 'bar'

  #>> Then foo should equal bar

      foo.should.equal 'bar'

  #>> Call the function on a timeout 

    setTimeout f, 3000
  '''

specs.push mySpec2 = new Spec 
  name: 'async2'
  specDSL: code2
  isCoffee: true

#>> When I run the specs


runSpecs specs, (specs) ->

  specs[0].name.should.equal "async1"
  specs[0].status.should.equal 'pass'

  specs[1].name.should.equal "async2"
  specs[1].status.should.equal 'pass'
  

