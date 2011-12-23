path           = require 'path'
boxy           = require 'boxy'
SpexSandbox    = require '../../sandbox/sandbox.agent'
buildScenarios = require './buildScenarios'
buildTest      = require './buildTest'

runSpec = (spec, next) ->  

  buildScenarios spec.specDSL, (scenarios) ->

    specPath = (path.join spec.specDir, spec.name) + ".coffee"
    spec.scenarios = scenarios  
    spexDSL = new SpexSandbox spec, (spec) -> next null, spec
    sandbox =
      spex         : spexDSL 
      '__dirname'  : spec.specDir
      '__filename' : specPath

    buildTest spec.scenarios, (testCode) ->
            
      boxy.exe 
        code: testCode
        sandbox: sandbox
        filename: specPath
        next: (result) ->
          #fail
          if result.status is 'fail'
            spec = result.sandbox.spex.spec
            id   = result.error.spexScenarioId ? 0
            spec.status = 'fail'
            spec.scenarios[id].status = 'fail'
            spec.scenarios[id].error = result.error
            next null, spec

module.exports = runSpec
