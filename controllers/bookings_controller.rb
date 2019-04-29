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

#new booking with member pre-populated
get '/bookings/:id/newm' do
  @member = Member.find(params[:id])
  @members = Member.all()
  @classes = Classe.all()
  erb(:"bookings/newm")
end

#new booking with class pre-populated
get '/bookings/:id/new' do
  @classe = Classe.find(params[:id])
  @members = Member.all()
  @classes = Classe.all()
  erb(:"bookings/newc")
end

#edit
get '/bookings/:id/edit' do
  @booking = Booking.find(params[:id])
  @members = Member.all()
  @classes = Classe.all()
  erb(:"bookings/edit")
end

#update
post '/bookings/:id' do
  booking = Booking.new(params)
  booking.update()
  redirect to '/bookings'
end

#delete
post '/bookings/:id/delete' do
  booking = Booking.find(params[:id])
  booking.delete()
  redirect to '/bookings'
end
