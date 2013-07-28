class BlogPost < ActiveRecord::Base

  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :category
  belongs_to :user
  belongs_to :picture
  belongs_to :city

#  mount_uploader :mp3file, Mp3Uploader

  acts_as_taggable

  after_initialize :set_defaults

  validates_presence_of :headline, :headline_teaser, :teaser_text, :text, :user, :category, :publishable_from, :picture_id, :blog_type, :mp3file

  scope :for_web, lambda { where( "publishable = ? and publishable_from <= ?", true, Time.zone.now ).order("publishable_from desc") }
  scope :most_recent, where("publishable = ? and publishable_from <= ?", true, Time.zone.now).order("publishable_from DESC").limit(30)
  scope :blog, where("blog_type = 'blog'")
  scope :podcast, where("blog_type = 'podcast'")

  def self.search(search)
    find(:all, :conditions => ['headline LIKE ? OR headline_teaser LIKE ? OR teaser_text
      LIKE ? OR text LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
  end

  def to_param
    "#{id}-#{headline.parameterize}"
  end

  def to_link
    "#{publishable_from.year}/#{publishable_from.month}/#{publishable_from.day}/#{id}-#{headline.parameterize}"
  end

  def get_podcast_url
    if mp3file.starts_with? 'http'
      mp3file
    else
      "https://nerdhub.s3.amazonaws.com/uploads/blog_post/mp3file/#{self.id}/#{mp3file}"
    end
  end 
  
  def to_s
    headline
  end

  def title
    headline
  end

  # This is needed for the comments controller
  def name
    headline
  end

  private

  def set_defaults
    self.publishable_from = Time.now if self.publishable_from.blank?
  end
end




