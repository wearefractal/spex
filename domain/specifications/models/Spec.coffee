class Spec
  constructor: ({@name, @specDSL, @isCoffee}) ->
    @status = 'notrun'
    @scenarios = []


module.exports = Spec
