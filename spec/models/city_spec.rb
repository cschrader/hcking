require 'spec_helper'

describe City do
  it "should validate presence of name" do

    city = City.new name: 'city'
    city.valid?.should be_true

    city_without_name = City.new
    city_without_name.valid?.should be_false
  end
end
