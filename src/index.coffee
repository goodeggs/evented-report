csv = require 'csv'
{EventEmitter} = require 'events'

class Report extends EventEmitter
  columns: []
  toCSV: (outputStream) ->
    options = {}
    if @columns.length
      options.columns = @columns
      options.header = true

    writer = csv().to.stream(outputStream, options)
    @on 'data', writer.write.bind(writer)
    @on 'end', writer.end.bind(writer)
    @run()

  run: ->
    throw new Error "You must implement Report::run in your subclass"

module.exports = Report
