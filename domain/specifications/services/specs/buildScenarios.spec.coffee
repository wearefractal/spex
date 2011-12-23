#>> Setup

require 'should'
buildScenarios = require '../buildScenarios'
Scenario       = require '../../models/Scenario'

#>> Given a some spec DSL

dsl = 
  '''
  #>> Given some dsl code
    foo = "foo" 
  #>> Then Bar is bar
    bar =  "bar"
  '''

#>> When I pass *buildScenarios* the DSL code

buildScenarios dsl, (scenarios) ->

#>> Then

  scenarios.length.should.equal 2
  scenario.should.be.an.instanceof Scenario for scenario in scenarios

