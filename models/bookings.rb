require_relative('../db/sql_runner.rb')


class Booking

  attr_reader(:member_id, :class_id)

  def initialize(options)
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
    SqlRunner.run()
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
