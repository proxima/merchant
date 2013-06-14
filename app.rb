require "sinatra"
require "sinatra/activerecord"

set :database, "sqlite3:///merchant.db"
set :port, 4000

class Restriction < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
end

class Sector < ActiveRecord::Base
  has_many :exits, :class_name => "Exit", :dependent => :destroy, :order => 'direction ASC', :foreign_key => :source_sector_id
  has_many :entrances, :class_name => "Exit", :dependent => :destroy, :order => 'direction ASC', :foreign_key => :dest_sector_id

  def adjacent_sector?(direction)
    self.exits.each do |e|
      if e.direction == direction
        return true
      end
    end
    false
  end

  def adjacent_sector(direction)
    self.exits.each do |e|
      if e.direction == direction
        return e.destination
      end
    end
    return nil
  end
end

class Exit < ActiveRecord::Base
  belongs_to :source, :class_name => "Sector", :foreign_key => :source_sector_id
  belongs_to :destination, :class_name => "Sector", :foreign_key => :dest_sector_id

  #north, east, south, west, jump
  DIRECTIONS = [ 0, 1, 2, 3, 4 ]
  COSTS = [ 1, 5 ]

  validates :cost, :inclusion => {:in => COSTS}
  validates :dest_sector_id, :presence => true, :uniqueness => {:scope => :source_sector_id}, :numericality => true
  validates :direction, :inclusion => {:in => DIRECTIONS}, :numericality => true
  validates :source_sector_id, :presence => true, :uniqueness => {:scope => :dest_sector_id}, :numericality => true
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
