class City < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :name, :description, :latitude, :longitude

  has_many :single_event
  has_many :blog_post

end
