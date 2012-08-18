require "sinatra/base"

class SRNA < Sinatra::Base
  get '/' do
    haml :index, format: :html5
  end
  
  post '/index' do
    haml :index, format: :html5
    # Construct config file
    # Write config file to disk? Display in browser?
  end
  
end