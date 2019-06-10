require('sinatra')
# require('sinatra/contrib/all')
require_relative('../models/bookings.rb')
require_relative('../models/classes.rb')
require_relative('../models/members.rb')
# also_reload('../models/*')

#index
get '/classes' do
  @classes = Classe.all()
  erb(:"classes/index")
end

#new
get '/classes/new' do
  erb(:"classes/new")
end

#class listings
get '/classes/list' do
  @classes = Classe.list_upcoming_class_times
  erb(:"classes/list")
end

#timetable
get '/classes/timetable' do
  @classes = Classe.all()
  erb(:"classes/timetable")
end

#show
get '/classes/:id' do
  @members = Member.all()
  @classe = Classe.find(params[:id])
  erb(:"/classes/show")
end

#Create
post '/classes' do
  classe = Classe.new(params)
  classe.save()
  redirect to '/classes'
end

#Edit
get '/classes/:id/edit' do
  @classe = Classe.find(params[:id])
  erb(:"classes/edit")
end

#Update
post '/classes/:id' do
  classe = Classe.new(params)
  classe.update()
  redirect to '/classes'
end

#delete
post '/classes/:id/delete' do
  classe = Classe.find(params[:id])
  classe.delete()
  redirect to '/classes'
end
