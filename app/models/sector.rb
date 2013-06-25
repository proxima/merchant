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

  def to_rowcol
    g = self.galaxy
    position = self.id - g.min_sector_id
    return position / g.dimension, position % g.dimension
  end

  def surrounding_sectors(radius)
    g = self.galaxy

    position = self.id - g.min_sector_id

    row = position / g.dimension 
    col = position % g.dimension

    ret = []

    mini_dimension = ((radius * 2) + 1)
  
    (-radius..radius).each do |row_radius|
      cur_row = []
      (-radius..radius).each do |col_radius|
        new_row = (row + row_radius) % g.dimension 
        new_col = (col + col_radius) % g.dimension

        cur_row << (new_row * g.dimension) + new_col + g.min_sector_id
      end
      ret << cur_row
    end

    return ret
  end

  def self.test(id, radius)
    s = Sector.find(id)
    ret = s.surrounding_sectors(radius)
    ret.each do |r|
      p r
    end
  end
end
