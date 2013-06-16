require "sinatra/activerecord"

class Galaxy < ActiveRecord::Base
  belongs_to :race

  validates :min_sector_id, :numericality => true
  validates :max_sector_id, :numericality => true
  validates :dimension, :numericality => true
  validates :race_id, :uniqueness => true, :numericality => true

  validate :min_max_sector_id
  validate :no_racial_overlap
  
  def min_max_sector_id
    if max_sector_id <= min_sector_id
      errors.add(:min_sector_id, "min sector num must be less than max sector num")
      return
    end

    difference = (max_sector_id - min_sector_id) + 1
    square_root = Math.sqrt(difference)
    
    if square_root != dimension
      errors.add(:dimension, "sqrt(max_sector_id - min_sector_id) must equal the dimension")
      return
    end
  end

  def no_racial_overlap
    Race.find(:all).each do |r|
      if r.galaxy
        g = r.galaxy
        if (min_sector_id..max_sector_id).include?(g.min_sector_id)
          errors.add(:min_sector_id, "sectors overlap with the " + r.name + " galaxy.")
          return
        end
        if (min_sector_id..max_sector_id).include?(g.max_sector_id)
          errors.add(:min_sector_id, "sectors overlap with the " + r.name + " galaxy.")
          return
        end
      end
    end
  end

  def sectors
    s = Sector.where("id >= ? AND id <= ?", self.min_sector_id, self.max_sector_id)
    return s
  end
end
