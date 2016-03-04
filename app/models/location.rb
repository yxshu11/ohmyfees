class Location < ActiveRecord::Base
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode
  
  validates :name, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
end
