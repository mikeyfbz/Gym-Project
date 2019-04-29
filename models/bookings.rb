require_relative('../db/sql_runner.rb')


class Booking

  attr_reader :id, :member_id, :class_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @member_id = options['member_id'].to_i
    @class_id = options['class_id'].to_i
  end

  def save()
    sql = "INSERT INTO bookings (member_id, class_id) VALUES ($1, $2) RETURNING id;"
    values = [@member_id, @class_id]
    result = SqlRunner.run(sql, values)[0]
    @id = result['id'].to_i
  end

  def delete()
    sql = "DELETE FROM bookings WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE bookings SET (member_id, class_id) = ($1, $2) WHERE id = $3;"
    values = [@member_id, @class_id, @id]
    SqlRunner.run(sql,values)
  end

  def get_member_details()
    sql = "SELECT * FROM members
    INNER JOIN bookings
    ON members.id = bookings.member_id
    WHERE bookings.id = $1;"
    values = [@id]
    name = SqlRunner.run(sql, values)
    return Member.map_items(name)
  end

  def get_class_details()
    sql = "SELECT * FROM classes
    INNER JOIN bookings
    ON classes.id = bookings.class_id
    WHERE bookings.id = $1;"
    values = [@id]
    classe = SqlRunner.run(sql, values)
    return Classe.map_items(classe)
  end

  def self.remove_old_bookings()
    sql = "SELECT bookings.* FROM bookings
    INNER JOIN classes
    ON classes.id = bookings.class_id
    WHERE time > CURRENT_TIME
    ORDER BY time;"
    results = SqlRunner.run(sql)
    return Booking.map_items(results)
  end



  def self.find(id)
    sql = "SELECT * FROM bookings WHERE id = $1;"
    values = [id]
    booking = SqlRunner.run(sql,values)
    result = Booking.new(booking[0])
    return result
  end

  def self.all()
    sql = "SELECT * FROM bookings"
    results = SqlRunner.run(sql)
    return self.map_items(results)
  end

  def self.delete_all()
    sql = "DELETE FROM bookings"
    SqlRunner.run(sql)
  end

  def self.map_items(booking_data)
    result = booking_data.map { |booking| Booking.new(booking) }
    return result
  end
end
