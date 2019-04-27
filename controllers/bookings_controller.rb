require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')
require_relative('../models/bookings.rb')
require_relative('../models/classes.rb')
require_relative('../models/members.rb')
also_reload('../models/*')

#index
get '/bookings' do
  @bookings = Booking.all()
  erb(:"bookings/index")
end

#new
get '/bookings/new' do
  @members = Member.all()
  @classes = Classe.all()
  erb(:"bookings/new")
end

#show
get '/bookings/:id' do
  @booking = Booking.find(params[:id])
  erb(:"bookings/show")
end

#create
post '/bookings' do
  booking = Booking.new(params)
  booking.save()
  redirect to '/bookings'
end
