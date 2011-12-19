#>> Setup

_ = require('slice') __dirname
require 'should'
buildTest = _.load 'specifications.buildTest'
Scenario = _.load 'scenarios.Scenario'

#>> Given some Scenarios

scenarios = []

scenarios.push new Scenario 
  id: 0
  name: 'foo1'
  code: 'foo = "fo222o";'

scenarios.push new Scenario 
  id: 1
  name: 'foo2'
  code: 'fooo = function() { doThing(); }'

scenarios.push new Scenario 
  id: 2
  name: 'foo3'
  code: 'foo3 = "fo222o";'

#>> When I run buildTest

buildTest scenarios, (testCode) ->

  console.log testCode

#>> Then
###
#  testCode.should.equal '''
    Error.prototype.spexScenarioId = 0;
    foo = "fo222o";
    spex.pass(0);
    Error.prototype.spexScenarioId = 1;
    foo2 = "fo222o";
    spex.pass(1);
    Error.prototype.spexScenarioId = 2;
    foo3 = "fo222o";
    spex.pass(2);
    '''
