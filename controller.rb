require('sinatra')
require('sinatra/contrib/all')
require('pry-byebug')
require_relative('./models/bookings.rb')
require_relative('./models/classes.rb')
require_relative('./models/members.rb')
also_reload('./models/*')

get '/' do
  erb(:index)
end

get '/members' do
  @members = Member.all()
  erb(:members)
end

get '/gym/:id' do

end
