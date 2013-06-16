require "sinatra/activerecord"

class Race < ActiveRecord::Base
  has_many :players
  has_one :galaxy
  
  validates :name, :uniqueness => true, :presence => true
end

