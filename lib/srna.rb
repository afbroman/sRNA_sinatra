require "sinatra/base"

class SRNA < Sinatra::Base
  get '/' do
    erb :index
  end
  
  post '/index' do
    erb :index
    # Construct config file
    # Offer config file as attachment (see sinatra book p 44)
  end
  
end