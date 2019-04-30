require_relative('../db/sql_runner.rb')

class Member

  attr_reader(:id, :first_name, :last_name, :age, :membership_type)

  def initialize (options)
    @first_name = options['first_name']
    @last_name = options['last_name']
    @age = options['age'].to_i
    @membership_type = options['membership_type']
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO members (first_name, last_name, age, membership_type) VALUES ($1, $2, $3, $4) RETURNING id;"
    values = [@first_name, @last_name, @age, @membership_type]
    result = SqlRunner.run(sql, values)[0]
    @id = result['id'].to_i
  end

  def update()
    sql = "UPDATE members SET (first_name, last_name, age, membership_type) = ($1, $2, $3, $4) WHERE id = $5;"
    values = [@first_name, @last_name, @age, @membership_type, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM members where id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def premium_member()
    if @membership_type == 'Premium'
      return true
    else
      return false
    end
  end

def list_all_classes_member_booked_into()
  sql = "SELECT bookings.* FROM members
  INNER JOIN bookings
  ON members.id = bookings.member_id
  INNER JOIN classes
  ON bookings.class_id = classes.id
  WHERE members.id = $1;"
  values = [@id]
  results = SqlRunner.run(sql, values)
  class_bookings = Booking.map_items(results)
  return class_bookings
end


  def self.find(id)
    sql = "SELECT * FROM members WHERE id = $1;"
    values = [id]
    member = SqlRunner.run(sql, values)
    result = Member.new(member.first)
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM members"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM members
    ORDER BY first_name;"
    results = SqlRunner.run(sql)
    return self.map_items(results)
  end

  def self.map_items(member_data)
    result = member_data.map { |member| Member.new(member) }
    return result
  end
end
