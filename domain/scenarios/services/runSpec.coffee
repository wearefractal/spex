vm = require 'vm'
nodeSandbox = require 'node-sandbox'
log = require 'node-log'

runSpec = (spec) ->

  # the sandbox passes vars into the test being run accessible with @
  sandbox =
    spex: spec
    should: require 'should'

  # eval testCode with sandbox
  { status, sandbox, error } = nodeSandbox.eval spec.testCode, sandbox

  if status is 'ok'
    spec = sandbox.spex
    spec.status = 'pass'
  else
    spec = sandbox.spex
    spec.status = 'fail'
    spec.fail error.spexScenarioId, error

  return spec

module.exports = runSpec

### TEST

should = require 'should'
Spec = require('spex').load 'spec.models.Spec'

#>> Given some valid code in a Spec

code =
  ">> Given foo\n" +
  "  foo = 'foo'\n" +
  ">> When I change the value of foo\n" +
  "  foo = 'bar'\n" +
  ">> Then\n" +
  "  foo.should.equal 'bar'\n"

mySpec = new Spec 'myspec', code, true
mySpec.status.should.equal 'notrun'

#>> when I run the spec

runSpec mySpec

#>> Then

mySpec.status.should.equal 'pass'
