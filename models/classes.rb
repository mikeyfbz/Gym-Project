require_relative('../db/sql_runner.rb')

class Classe

  attr_reader :id, :name, :type, :capacity, :time

  def initialize (options)
    @name = options['name']
    @type = options['type']
    @capacity = options['capacity'].to_i
    @time = options['time'].to_f
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO classes (name, type, capacity, time) VALUES ($1,$2,$3,$4) RETURNING id;"
    values = [@name, @type, @capacity, @time]
    result = SqlRunner.run(sql, values)[0]
    @id = result['id'].to_i
  end

  def delete()
    sql = "DELETE FROM classes WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE classes SET (name, tyoe, capacity, time) = ($1, $2, $3, $4) WHERE id = $5;"
    values = [@name, @type, @capacity, @time, @id]
    SqlRunner.run(sql, values)
  end



  def self.all()
    sql = "SELECT * FROM classes"
    results = SqlRunner.run(sql)
    return results.map_items()
  end

  def self.delete_all()
    sql = "DELETE FROM classes"
    SqlRunner.run(sql)
  end

  def self.map_items(class_data)
    result = class_data.map { |item| Classe.new(item) }
    return result
  end

end