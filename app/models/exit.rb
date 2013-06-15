require "sinatra/activerecord"

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
