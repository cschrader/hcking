# encoding: utf-8
class Venue < ActiveRecord::Base
  attr_accessible :url, :country, :latitude, :location, :longitude, :street, :zipcode, :city_name
  validates_presence_of :location, :city_id, :country, :street, :zipcode

  has_many :events
  has_many :single_events
  #belongs_to :city

  after_validation :geocode
  before_save :desnormalize_city

  geocoded_by :address

  default_scope order(:location)

  def address
    [self.street, "#{self.zipcode} #{self.city_name}"].delete_if {|d| d.blank?}.collect{|d|d.strip}.join(", ")
  end

  def to_s
    location
  end

  def to_opengraph
    {
      "og:latitude"=>latitude,
      "og:longitude"=>longitude,
      "og:locality"=>location,
      "og:postal-code"=>zipcode,
      "og:street-address"=>street,
      "og:country-name"=>country
    }
  end

  def desnormalize_city
    c = City.find self.city_id
    self.city_name = c.name
  end
end
