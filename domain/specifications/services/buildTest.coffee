log = require 'node-log'
coffee = require 'coffee-script'

buildTest = (scenarios, isCoffee) ->

  @testCode = ''

  for scenario, index in scenarios
    nextSpace = scenario.leadspace
    if nextScenario = scenarios[index+1]
      nextSpace = nextScenario.leadspace

    @testCode +=
      "#{ scenario.leadspace }Error.prototype.spexScenarioId = #{ scenario.id }\n" +
      "#{ scenario.leadspace }#{ scenario.code }\n" +
      "#{ nextSpace }sandbox.spex.pass #{ scenario.id }\n"

  # bare strips the default closure container
  if isCoffee then @testCode = coffee.compile @testCode , {bare: true} 

  return @testCode


module.exports = buildTest

### TEST

should = require 'should'
Scenario = require('spex').load 'spec.models.Scenario'

#>> Given some Scenarios

scenarios = []
scenarios.push new Scenario 0, 'foo1', 'foo = "fo222o"', "  "
scenarios.push new Scenario 1, 'foo2', 'foo = "fdddoo"', "  "
scenarios.push new Scenario 2, 'foo3', 'foo = "fdddoo"', "  "

#>> When I run buildTest

testCode = buildTest scenarios, true

#>> Then

##testCode.trim().should.equal(
 'Error.prototype.spexScenarioId = 0;\nfoo = "fo222o";\nthis.spex.pass(0);\nError.prototype.spexScenarioId = 1;\nfoo = "fdddoo";\nthis.spex.pass(1);\nError.prototype.spexScenarioId = 2;\nfoo = "fdddoo";\nthis.spex.pass(2);')
