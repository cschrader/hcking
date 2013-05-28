class City < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :name, :description, :latitude, :longitude

  has_many :single_events
  has_many :blog_posts
  has_many :suggestions
  has_many :boxes

  validates_presence_of :name

  after_save :default_city_update

  def default_city_update
    if self.default
       c = City.default_city
       c.default = false
       c.save!
    end
  end

  def self.default_city
   1# (City.find_by_default true)
  end
end
