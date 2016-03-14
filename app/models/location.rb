class Location < ActiveRecord::Base

  # Check the name of the location is presented
  validates :name, presence: true
  # Check the latitude of the location is presented and in number format
  validates :latitude, presence: true, numericality: true
  # Check the longitude of the location is presented and in number format
  validates :longitude, presence: true, numericality: true
end
