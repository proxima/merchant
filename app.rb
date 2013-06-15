require "sinatra"
require "sinatra/activerecord"

Dir[File.dirname(__FILE__) + "/app/models/*.rb"].each do |f|
  puts "Loading model: #{f}"
  require f
end

set :database, "sqlite3:///merchant.db"
set :port, 4000

# Get all of our routes
get "/" do
  erb :"canvas/index"
end

helpers do
  def title
    if @title
      "#{@title} -- Merchant"
    else
      "Merchant"
    end
  end
end 
