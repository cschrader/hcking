class City < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :name, :description, :latitude, :longitude#, :default

  has_many :single_events
  has_many :blog_posts
  has_many :suggestions
  has_many :boxes

  validates_presence_of :name

  def self.default_city
   City.find_by_default true
  end
end
