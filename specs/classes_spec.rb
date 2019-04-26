require('minitest.autorun')
require('minitest/rg')
require_relative('../models/classes.rb')

class TestClasses < MiniTest::Test

  def setup
    @member1 = Member.new({'first_name' => 'John', 'last_name' => 'Hall', 'age' => '20'})

    @class1 = Classe.new({'name' => 'HIIT', 'type' => 'cardio', 'capacity' => '15', 'time' => '13:30'})

    @booking1 = Booking.new({'member_id' => @member1.id, 'class_id' => @class1.id})
  end




end
