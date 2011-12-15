#>> Setup

should = require 'should'

#>> Given a some spec DSL

dsl = 
'''#>> Given some dsl code\nfoo = "foo"\n>> Then Bar is bar\nbar = "bar"'''

#>> When I pass *buildScenarios* the DSL code

scenarios = buildScenarios dsl

#>> Then

scenarios.length.should.equal 2 # and
scenario.should.be.an.instanceof Scenario for scenario in scenarios

