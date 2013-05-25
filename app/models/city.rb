class City < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :name, :description, :latitude, :longitude

  has_many :single_event
  has_many :blog_post
  has_many :suggestion
  has_many :blox
  has_many :venues

  validates_presence_of :name

end
