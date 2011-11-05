log = require 'node-log'; log.setName 'gwan'
util = require 'util'; dump = (obj) -> log.info util.inspect(obj)
#spex = require( require('path').join __dirname, '../lib/spex/controller' )
require '../rzr/slice'

# $ spex run - Runs all tests in ./specs/
# TODO: support selective test running

exports.exe = (cmd, args) ->

#  spex.report spex.readFromDir 'specs' # TODO: support more options for spec reading
  dump spex.readFromDir './specs' # TODO: support more options for spec reading

