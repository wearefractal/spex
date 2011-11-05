
>> Given an EventEmitter with a listener for 'foo' events

  EventEmitter = require('events').EventEmitter
  ee = new EventEmitter
  ee.on 'foo', (done) ->
    done?('bar')

>> When a 'foo' event is emitted

  ee.emit 'foo', (bar) ->

>> Then bar should equal 'bar'

    bar.should.equal 'bar'

