#>> Given spex

require 'should'
spex = require '../spex.agent'

#>> Then

spex.should.have.property 'runSpec'
spex.should.have.property 'runSpecs'
