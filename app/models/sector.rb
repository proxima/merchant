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

  def surrounding_sectors(radius)
    g = self.galaxy

    row,col = (self.id - g.min_sector_id).divmod g.dimension

    ret = []

    (-radius..radius).each do |row_radius|
      cur_row = []
      (-radius..radius).each do |col_radius|
        cur_row << (((row + row_radius) % g.dimension) * g.dimension) + ((col + col_radius) % g.dimension) + g.min_sector_id
      end
      ret << cur_row
    end

    return ret
  end

  def local_map
    ret = []
    self.surrounding_sectors(2).each do |v|
      ret << Sector.find(v)
    end
    return ret
  end
end
