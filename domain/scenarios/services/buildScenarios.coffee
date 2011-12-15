parsimony = require 'parsimony'
Scenario = require('spex').load 'spec.models.Scenario'

buildScenarios = (specDSL) ->

  # generate AST of annotations and code blocks
  AST = parsimony.parse specDSL

  # create Scenario objects by mapping AST
  return scenarios = AST.map (block, index) -> new Scenario index, block.annotation, block.code, block.leadspace


module.exports = buildScenarios

### TEST

should = require 'should'

#>> Given a some spec DSL

dsl = '''>> Given some dsl code\nfoo = "foo"\n>> Then Bar is bar\nbar = "bar"'''

#>> When I pass *buildScenarios* the DSL code

scenarios = buildScenarios dsl

#>> Then

scenarios.length.should.equal 2 # and
scenario.should.be.an.instanceof Scenario for scenario in scenarios
