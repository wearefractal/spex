log = require 'node-log'; log.setName 'gwan'
coffee = require 'coffee-script'
should = require 'should'
async = require 'async'
util = require 'util'; dump = (obj) -> log.info util.inspect(obj)

# a **Feature** is something important that happens in your system
# a feature consists of scenarios which in turn consist of a description & block of code

class Spec
  status: 'notrun'

  constructor: (@name, spec, isCoffee, @done) ->
    # sandbox hack: namespace self for eval execution
    global.gwan = @

    @scenarios = gwan.parse spec

    # build test
    x = 0
    @testCode = ''
    buildTest = (scenario, done) =>
      leadspace = ""; nextSpace = ""
      if isCoffee
        leadspace = (scenario.code.match /^\n*(\s*)|[a-zA-Z]\n/)[1]
        if nextCode = @scenarios[x+1]?['code']
          nextSpace = (nextCode.match /^\n*(\s*)|[a-zA-Z]\n/)[1]
        else
          nextSpace = leadspace
      @testCode += "#{ leadspace }Error.prototype.scenario = #{ x }\n"
      @testCode += scenario.code
      @testCode += "#{ nextSpace }gwan.pass #{ x }\n" #@scenarios[#{ x }].status = 'pass'\n"
      x++
      done?()
    # change to reduce
    async.forEachSeries @scenarios, buildTest, (err) -> if err? then log.error "buildtest - #{ err }"

    if isCoffee # compile and clean
      code = coffee.compile @testCode
      code = code.split '\n'; code.pop();code.pop();code.shift(); code = code.join '\n'
      @testCode = code

    @runTest()
  ##
  runTest: ->
    try
      eval @testCode
      @status = 'pass'
    catch err
      @fail err.scenario, err
      @status = 'fail'
    @done?()

  pass: (id) -> @scenarios[id].status = 'pass'
  fail: (id, err) -> @scenarios[id].status = 'fail'; @scenarios[id].error = err

module.exports = Spec

### TEST >>

feature = new Feature 'test',
                      ">> foo\n\nconsole.log 'foo'\n\n>> bar\n\nconsole.log 'bar'",
                      true

