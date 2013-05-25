namespace :cities do

  desc "Create cities from Venue model"
  task create_cities: :environment do
    Venue.select(:city).uniq.each do |v|
      City.create(:name => v.city_name.camelize) if v.city
    end
  end

  desc "Update all content with cCty model"
  task add_to_content: :environment do
    add_city_to_content
  end
end

def add_city_to_content

  Venue.all.each do |venue|
    c = City.find_by_name venue.city_name.camelize
    venue.city_id = c.id
    venue.save!
  end

end