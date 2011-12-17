_ = require('slice') __dirname
boxy = _.load 'boxy'
SpexSandbox = _.load 'sandbox.agent'
buildTest = _.load 'specifications.buildTest'

runSpec = (spec, next) ->

  sandbox =
    spex: new SpexSandbox spec, next
    should: require 'should'    

  boxy.exe (buildTest @spec), sandbox
      

module.exports = runSpec
