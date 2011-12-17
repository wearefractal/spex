class SandboxAgent    

  constructor: (@spec, @next) ->

  pass: (scenarioId) -> 
    @spec.scenarios[scenarioId] = 'pass'
    @checkIfAllPassing()       

  fail: (scenarioId, error) ->
    @spec.status = 'fail'
    @spec.scenarios[scenarioId].status = 'fail'
    @spec.scenarios[scenarioId].error = error
    @next spec

  checkIfAllPassing: ->
    if @allPassing()
      @spec.status = 'pass'
      @next spec
      
  allPassing: ->
    for scenario in @spec.scenarios
      if scenario.status != 'pass' then return false
    return true


module.exports = SandboxAgent
