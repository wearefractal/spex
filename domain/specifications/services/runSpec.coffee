_ = require('slice') __dirname
require 'should'
boxy = _.load 'boxy'
SpexSandbox = require '../../sandbox/sandbox.agent'
buildTest = _.load 'specifications.buildTest'

runSpec = (spec, next) ->
  
  spexDSL = new SpexSandbox spec, (spec) -> next spec

  sandbox =
    spex: spexDSL 

  buildTest spec.scenarios, (testCode) ->

    boxy.exe testCode, sandbox, (result) ->
      if result.status is 'fail'
        console.log result.sandbox
        console.log result.error
        spec = result.sandbox.spex.spec
        id = result.error.spexScenarioId
        spec.status = 'fail'
        spec.scenarios[id].status = 'fail'
        spec.scenarios[id].error = result.error
        next spec

module.exports = runSpec
