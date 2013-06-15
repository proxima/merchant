require "sinatra/activerecord"

class Player < ActiveRecord::Base
  belongs_to :sector
  belongs_to :race

  validates :name, :uniqueness => true, :length => { :minimum => 4, :maximum => 16 }
  validates :facebook_id, :uniqueness => true, :numericality => true
  validates :sector_id, :presence => true, :numericality => true
  validates :race_id, :presence => true, :numericality => true
end

