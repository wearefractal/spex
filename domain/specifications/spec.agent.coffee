_ = require 'slice'
buildScenarios = _.load 'spec.buildScenarios'
buildTest = _.load 'spec.services.buildTest'

# a **Spec** is a specification describing 
# some important feature of your system
# a Spec consists of **Scenarios**

class SpecAgent
  constructor: (@spec) ->

    {@name, specDSL, @isCoffee, done}

    @status = 'notrun'

    @scenarios = buildScenarios specDSL
    @testCode = buildTest @scenarios, @isCoffee

  pass: (id) -> @scenarios[id].pass()
  fail: (id, err) -> @scenarios[id].fail err

module.exports = Spec

### TEST #functional

should = require 'should'

#>> Given some spec code

code = ">> Given some spec code\nfoo = 'foo'"

#>> When you create a new Spec

mySpec = new Spec 'myspec', code, true
mySpec.should.be.an.instanceof Spec
mySpec.scenarios.length.should.equal 1

