require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')
require_relative('../models/bookings.rb')
require_relative('../models/classes.rb')
require_relative('../models/members.rb')
also_reload('../models/*')

#index
get '/members' do
  @members = Member.all()
  erb(:"members/index")
end

#new
get '/members/new' do
  erb(:'members/new')
end

#show
get '/members/:id' do
  @member = Member.find(params[:id])
  erb(:"members/show")
end

#create
post '/members' do
  member = Member.new(params)
  member.save()
  redirect to '/members'
end

#edit
get '/members/:id/edit' do
  @member = Member.find(params[:id])
  erb(:"members/edit")
end

#update
post '/member/:id' do
  member = Member.new(params)
  member.update()
  redirect to '/members'
end

#delete
post '/members/:id/delete' do
  member = Member.find(params[:id])
  member.delete()
  redirect to '/members'
end
