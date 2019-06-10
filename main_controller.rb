require('sinatra')
require('sinatra/contrib/all')

require_relative('./controllers/classes_controller.rb')
require_relative('./controllers/members_controller.rb')
require_relative('./controllers/bookings_controller.rb')
also_reload('./models/*')

get '/' do
  erb(:index)
end
