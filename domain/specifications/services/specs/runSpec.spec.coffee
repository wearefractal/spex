#>> Setup

should = require 'should'
Spec = _.load 'specifications.Spec'

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

