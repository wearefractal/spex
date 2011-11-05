log = require 'node-log'; log.setName 'gwan'
util = require 'util'; dump = (obj) -> log.info util.inspect(obj)
readFromDir = require('spex').load 'services.readFromDir'
report = require('spex').load 'services.report'


# $ spex test - Runs all tests in ./specs/
# TODO: support selective test running

exports.exe = (cmd, args) ->

  specs = readFromDir './specs' # TODO: support more options for spec reading
  console.log specs
#  report specs

