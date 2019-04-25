require_relative('../db/sql_runner.rb')

class Class

  attr_reader :id, :name, :type, :capacity, :time

  def initialize (options)
    @name = options['name']
    @type = options['type']
    @capacity = options['capacity'].to_i
    @time = options['time'].to_f
    @id = options['id'].to_i if options['id']
  end

  


end
