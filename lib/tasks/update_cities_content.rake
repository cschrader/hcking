namespace :cities do

  desc "Create cities from Venue model"
  task create_cities: :environment do
    Venue.select(:city_name).uniq.each do |v|
      City.create(:name => v.city_name.camelize) if v.city_name
    end
  end

  desc "Update all content with citiesty model"
  task add_to_content: :environment do
    add_city_to_content
    add_city_to_single_events
  end
end

def add_city_to_content
  Venue.all.each do |venue|
    c = City.find_by_name venue.city_name.camelize
    venue.city_id = c.id
    venue.save!
  end
end

def add_city_to_single_events
  SingleEvent.all.each do |se|
    se.city_id = se.venue.city_id if !se.venue.nil?
    se.save!
  end
end