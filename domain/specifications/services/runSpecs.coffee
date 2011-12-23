async   = require 'async'
runSpec = require './runSpec'

runSpecs = (specs, next) ->

  async.map specs, runSpec, (err, specs) -> 
    if err? then next err
    else 
    next null, specs

module.exports = runSpecs
