coffee = require 'coffee-script'

buildTest = (scenarios, next) ->

  initialLeadspace = scenarios[0].leadspace

  scenarios = scenarios.map (scenario, index) ->   
    nextSpace = scenario.leadspace
    if nextScenario = scenarios[index+1]
      nextSpace = nextScenario.leadspace
    return testCode =
      "#{ scenario.leadspace }" + 
      "Error.prototype.spexScenarioId = " +
      "#{ scenario.id }\n" +
      "#{ scenario.leadspace }#{ scenario.code }\n" +
      "#{ nextSpace }sandbox.spex.pass #{ scenario.id }\n"

  #include should
  #scenarios.unshift "#{ initialLeadspace }require 'should'\n"
  testCode = scenarios.join ''

  # bare strips the default closure container
  next (coffee.compile testCode, {bare: true}).trim()
  

module.exports = buildTest
