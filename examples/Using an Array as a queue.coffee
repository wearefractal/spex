#>> Given an Array

  array = []

#>> When some things are added

  array.push 1
  array.push 2
  array.push 3
  array.push 4

#>> And an element is shifted off the array

  element = array.shift()

#>> Then that element should be the first element from the array

  element.should.equal 1

#>> And the other _elements_ should remain - WRONG ON PURPOSE

  array.length.should.equal 4

#>> Also, the shifted off element should not exist in array

  array.should.not.contain element

