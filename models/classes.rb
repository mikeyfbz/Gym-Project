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
    sql = "UPDATE classes SET (name, type, capacity, time) = ($1, $2, $3, $4) WHERE id = $5;"
    values = [@name, @type, @capacity, @time, @id]
    SqlRunner.run(sql, values)
  end

  def get_all_members_in_a_class()
    sql = "SELECT first_name, last_name FROM classes
    INNER JOIN bookings
    on classes.id = bookings.class_id
    INNER JOIN members
    on members.id = bookings.member_id
    WHERE classes.id = $1;"
    values = [@id]
    names_hash = SqlRunner.run(sql, values)
    names_array = Member.map_items(names_hash)
    return names_array
  end


  def self.find(id)
    sql = "SELECT * FROM classes WHERE id = $1;"
    values = [id]
    classe = SqlRunner.run(sql, values)
    result = Classe.new(classe.first)
    return result
  end

  def self.all()
    sql = "SELECT * FROM classes"
    results = SqlRunner.run(sql)
    return self.map_items(results)
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
