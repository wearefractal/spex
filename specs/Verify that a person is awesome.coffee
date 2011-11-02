>> Given a Person class

  class Person
    constructor: (@first, @last, @SSN) ->
      setSSN()
    setSSN: ->
      throw new "invalid SSN"

>> When I create a person with an invalid SSN

  try
    person = new Person "nick", "vayasomethin", 344-23-333233
  catch err

>> Then the error should get thrown

    err.should.not.be.null

>> and the err.message should be "invalid SSN"

    err.message.should.be."invalid SSN"

