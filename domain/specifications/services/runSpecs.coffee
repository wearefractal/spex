_ = require 'slice'
async = _.load 'async'
runSpec = _.load 'specifications.runSpec'

runSpecs = (specs, next) ->

  async.map specs, runSpec, next


module.exports = runSpecs
