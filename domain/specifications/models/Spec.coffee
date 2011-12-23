class Spec
  constructor: ({@name, @specDSL, @isCoffee, @specDir}) ->
    @status = 'notrun'
    @scenarios = []


module.exports = Spec
