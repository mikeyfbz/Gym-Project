require_relative('../db/sql_runner.rb')

class Classe

  attr_reader :id, :name, :type, :capacity, :time

  def initialize (options)
    @name = options['name']
    @type = options['type']
    @capacity = options['capacity'].to_i
    @time = options['time']
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

  def get_class_attendance()
    sql = "SELECT bookings.id from classes
    INNER JOIN bookings
    ON classes.id = bookings.class_id
    INNER JOIN members
    ON bookings.member_id = members.id
    WHERE class_id = $1;"
    values = [@id]
    total = SqlRunner.run(sql, values)
    bookings_count = Booking.map_items(total).count
    return bookings_count
  end

  def check_if_class_is_full()
    if (@capacity > get_class_attendance())
      return false
    else
      return true
    end
  end

  def self.list_upcoming_class_times()
    sql = "SELECT * FROM classes
    WHERE time > CURRENT_TIME
    ORDER BY time;"
    results = SqlRunner.run(sql)
    array_of_classes = self.map_items(results)
    return array_of_classes
  end


  def self.find(id)
    sql = "SELECT * FROM classes WHERE id = $1;"
    values = [id]
    classe = SqlRunner.run(sql, values)
    result = Classe.new(classe.first)
    return result
  end

  def self.all()
    sql = "SELECT * FROM classes
    ORDER BY time;"
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
