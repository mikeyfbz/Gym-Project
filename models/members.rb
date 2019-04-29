require_relative('../db/sql_runner.rb')

class Member

  attr_reader(:id, :first_name, :last_name, :age)

  def initialize (options)
    @first_name = options['first_name']
    @last_name = options['last_name']
    @age = options['age'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO members (first_name, last_name, age) VALUES ($1, $2, $3) RETURNING id;"
    values = [@first_name, @last_name, @age]
    result = SqlRunner.run(sql, values)[0]
    @id = result['id'].to_i
  end

  def update()
    sql = "UPDATE members SET (first_name, last_name, age) = ($1, $2, $3) WHERE id = $4;"
    values = [@first_name, @last_name, @age, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM members where id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
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
