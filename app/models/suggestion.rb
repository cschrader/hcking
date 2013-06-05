class Suggestion < ActiveRecord::Base
  attr_accessible :name,
    :occurrence,
    :description,
    :more,
    :more_as_text

  serialize :more, Hash

  belongs_to :city

  validates_presence_of :name,
    :occurrence,
    :city

  def more_as_text spacer = "\n"
    more.map {|key, value| "#{key}: #{value}"}.join spacer
  end

  def more_as_text=(raw)
    write_attribute "more", Hash[*raw.gsub(": ", "\n").split("\n")]
  end

  def more_as_inline
    more_as_text ", "
  end
end
