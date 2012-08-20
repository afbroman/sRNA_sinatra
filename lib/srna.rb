require "sinatra/base"

class SRNA < Sinatra::Base
  get '/' do
    @genomes = SRNA.load_genomes
    erb :index
  end
  
  post '/result' do
    erb :result
    # Construct config file
    # Offer config file as attachment (see sinatra book p 44)
  end

  def self.load_genomes
    genomes = Array.new  
    File.open(File.dirname(__FILE__) + '/db/genomes.txt').each do |row|  
      genomes << row.chomp.split('#')
    end  

    # Remove the first three metadata lines and sort by name (second item in each internal array)
    genomes.drop(3).sort do |a, b|
      comp = a[1].downcase <=> b[1].downcase
      comp.zero? ? (a[2].downcase <=> b[2].downcase) : comp
    end
  end  
  
end