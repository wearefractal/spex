class ScenarioAgent
  constructor: (@scenario) ->

    if !scenario.id? 
      throw new Error "Scenario was not passed an *id*"

    @status = 'notrun'

#    repo.add 'scenario', scenario
#    repo.add 'status', 'notrun'

  pass: -> @status = 'pass'
  fail: (@error) -> @status = 'fail'


