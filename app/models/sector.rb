require "sinatra/activerecord"

class Sector < ActiveRecord::Base
  has_many :exits, :class_name => "Exit", :dependent => :destroy, :order => 'direction ASC', :foreign_key => :source_sector_id
  has_many :entrances, :class_name => "Exit", :dependent => :destroy, :order => 'direction ASC', :foreign_key => :dest_sector_id
  has_many :players

  def adjacent_sector?(direction)
    e = Exit.where("source_sector_id = ? AND direction = ?", self.id, direction).limit(1)
    return e.size > 0
  end

  def adjacent_sector(direction)
    e = Exit.where("source_sector_id = ? AND direction = ?", self.id, direction).limit(1)
    return e[0].destination if e.size > 0
    return nil
  end

  def galaxy
    g = Galaxy.where("min_sector_id <= ? AND max_sector_id >= ?", self.id, self.id).limit(1)
    return g[0] if g.size > 0
    return nil
  end
end
