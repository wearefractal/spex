_ = require 'slice'
boxy = _.load 'boxy'
buildTest = _.load 'specifications.buildTest'

runSpec = (spec, next) ->

  sandbox = 
    spex: spec
  
  boxy.exe (buildTest spec), sandbox, (result) ->

    spec = result.sandbox.spex
    
    if result.status is 'ok'
      spec.status = 'pass'
      next spec
    else
      spec.status = 'fail'      
      spec.fail error.spexScenarioId, error
      

module.exports = runSpec
