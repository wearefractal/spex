allScenariosPass = require './services/allScenariosPass'

class SandboxAgent    

  constructor: (@spec, @next) ->
  
  pass: (id) -> 
    @spec.scenarios[id].status = 'pass'
    if allScenariosPass @spec.scenarios
      @spec.status = 'pass'
      @next @spec
     

module.exports = SandboxAgent
