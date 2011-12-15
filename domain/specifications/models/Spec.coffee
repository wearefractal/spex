class Spec
  constructor: ({@name, @specDSL, @isCoffee}) ->
    @status = 'notrun'
    @scenarios = []

  pass: (id) -> @scenarios[id].pass()
  fail: (id, error) -> @scenarios[id].fail error


module.exports = Spec
