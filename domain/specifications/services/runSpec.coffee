require 'should' # modifies object prototype
_ = require('slice') __dirname

boxy           = _.load 'boxy'
SpexSandbox    = _.load 'sandbox.agent'
buildScenarios = _.load 'specifications.buildScenarios'
buildTest      = _.load 'specifications.buildTest'

runSpec = (spec, next) ->
  
  buildScenarios spec.specDSL, (scenarios) ->

    spec.scenarios = scenarios  
    spexDSL = new SpexSandbox spec, (spec) -> next null, spec
    sandbox =
      spex: spexDSL 

    buildTest spec.scenarios, (testCode) ->

      
      boxy.exe testCode, sandbox, (result) ->
        #fail
        if result.status is 'fail'
          spec = result.sandbox.spex.spec
          id = result.error.spexScenarioId
          spec.status = 'fail'
          spec.scenarios[id].status = 'fail'
          spec.scenarios[id].error = result.error
          next null, spec

module.exports = runSpec
