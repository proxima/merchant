require "sinatra/activerecord"

class Sector < ActiveRecord::Base
  has_many :exits, :class_name => "Exit", :dependent => :destroy, :order => 'direction ASC', :foreign_key => :source_sector_id
  has_many :entrances, :class_name => "Exit", :dependent => :destroy, :order => 'direction ASC', :foreign_key => :dest_sector_id
  has_many :players

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
