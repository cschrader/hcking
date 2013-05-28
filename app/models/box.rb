class Box < ActiveRecord::Base
  attr_accessible :content_id, :content_type, :grid_position, :carousel_position, :city_id

  belongs_to :content, polymorphic: true
  belongs_to :city

  scope :in_grid, where("grid_position is not null").order("grid_position ASC")
  scope :first_grid_row, in_grid.where("grid_position <= 3 AND city_id IS NULL ")
  scope :second_grid_row, in_grid.where("grid_position > 3 AND city_id IS NULL")
  scope :in_carousel, where("carousel_position is not null AND city_id IS NULL").order("carousel_position ASC")

  # Filter by cities
  scope :first_grid_row_by_city,
    lambda{|city| in_grid.where("grid_position <= 3 AND city_id = ? ",city)}
  scope :second_grid_row_by_city,
    lambda{|city| in_grid.where("grid_position > 3 AND city_id = ?",city)}
  scope :in_carousel_by_city,
    lambda{|city| where("carousel_position is not null AND city_id = ?",city).order("carousel_position ASC")}

    scope :in_next_from,
    lambda { |delta, start_date| where(occurrence: (start_date)..((start_date + delta).to_date)) }

  validates_uniqueness_of :grid_position, allow_nil: true, :scope => :city_id
  validates_uniqueness_of :carousel_position, allow_nil: true, :scope => :city_id
  validate :content_has_picture
  validates :grid_position, inclusion: {in: [1,2,3,4,5,6,nil]}
  validate :no_ad_in_the_carousel

  delegate :category, to: :content

  def is_ad?
    content_type == "Advertisement"
  end

  def ad
    throw "This is not an ad" unless is_ad?
    return Advertisement.homepage
  end

  def picture
    if is_ad?
      Advertisement.homepage.picture
    else
      content.picture
    end
  end

  def first_line
    [:headline_teaser, :occurrence].each do |method_name|
      return content.send method_name if content.respond_to? method_name
    end

    return nil
  end

  def first_line?
    !!first_line
  end

  def second_line
    [:headline, :title].each do |method_name|
      return content.send method_name if content.respond_to? method_name
    end

    return nil
  end

  def second_line?
    !!second_line
  end

  def content_has_picture
    if !is_ad? and content.picture.blank?
      errors.add(:content_id, "Selected content needs to have an image")
    end
  end

  def no_ad_in_the_carousel
    if is_ad? and carousel_position.present?
      errors.add(:carousel_position, "Sorry, you can't put advertisement into the carousel")
    end
  end
end
