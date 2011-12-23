tater    = require 'tater'
Scenario = require '../models/Scenario'

buildScenarios = (specDSL, next) ->

  # TODO factor to config file
  defaultDelim = "#>>"

  # generate annotated codeblocks with tater
  tater.parse 
    dsl: specDSL
    delim: defaultDelim
    next: (scenarios) ->

      # map codeblocks to Scenarios
      next scenarios.map (scenario, index) -> 
        new Scenario
          id: index
          name: scenario.annotation
          code: scenario.code
          leadspace: scenario.leadspace
      

module.exports = buildScenarios
