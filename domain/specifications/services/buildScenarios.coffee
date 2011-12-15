_ = require 'slice'
parsimony = _.load 'parsimony'
Scenario = _.load 'specifications.Scenario'

buildScenarios = (specDSL, next) ->

  # generate AST of annotations and code blocks
  parsimony.parse specDSL, (AST) ->

    next AST.map (block, index) -> 
      new Scenario index, block.annotation, block.code, block.leadspace


module.exports = buildScenarios
