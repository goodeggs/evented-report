BufferStream = require 'bufferstream'
chai = {expect} = require 'chai'

EventedReport = require '../src/'


class TestReport extends EventedReport
  constructor: (@testData) ->
  columns: ['foo', 'bar']
  run: ->
    for data in @testData
      @emit 'data', data
    @emit 'end'


describe 'evented-report', ->
  {output} = {}

  beforeEach ->
    output = new BufferStream(size: 'flexible')
    
  it 'works', (done) ->
    report = new TestReport [
      {foo: '1', bar: 'one'}
      {foo: '2', bar: 'two'}
      {foo: '3', bar: 'three'}
    ]

    report.on 'end', ->
      output = output.toString().split "\n"
      expect(output[0]).to.equal 'foo,bar'
      expect(output[1]).to.equal '1,one'
      expect(output[3]).to.equal '3,three'
      done()
      
    report.toCSV output
