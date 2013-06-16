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

get "/sectors/:id.json" do
  content_type :json
  Sector.find(params[:id]).to_json(:include => :exits)
end

get "/players/new" do
  @races = Race.find(:all)
  erb :"players/new"
end

post "/players/new" do
  @player = Player.new(params[:player])
  if @player.save
    redirect "/"
  else
    @races = Race.find(:all)
    erb :"players/new"
  end
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
