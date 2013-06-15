require "sinatra/activerecord"

class Restriction < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
end

