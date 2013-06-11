require "sinatra"
require "sinatra/activerecord"

set :database, "sqlite3:///merchant.db"
set :port, 4000

class Restriction < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
end

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
