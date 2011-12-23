#>> Setup

require 'should'
buildTest = require '../buildTest'
Scenario  = require '../../models/Scenario'

#>> Given some Scenarios

scenarios = []

scenarios.push new Scenario 
  id: 0
  name: 'foo1'
  code: 'foo = "fo222o"'
  leadspace: ''

scenarios.push new Scenario 
  id: 1
  name: 'foo2'
  code: 'foo2 = (foo) ->'
  leadspace: ''

scenarios.push new Scenario 
  id: 2
  name: 'foo3'
  code: 'foo3 = foo'
  leadspace: '  '

#>> When I run buildTest

buildTest scenarios, (testCode) ->

#>> Then

  testCode.should.equal 
  '''
  var foo, foo2;

  Error.prototype.spexScenarioId = 0;

  foo = "fo222o";

  spex.pass(0);

  Error.prototype.spexScenarioId = 1;

  foo2 = function(foo) {
    var foo3;
    spex.pass(1);
    Error.prototype.spexScenarioId = 2;
    foo3 = foo;
    return spex.pass(2);
  };
  '''

