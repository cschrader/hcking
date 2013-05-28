namespace :cities do

  desc "Update all content with citiesty model"
  task add_to_content: :environment do
    create_cities
    add_city_to_single_events
  end
end

def create_cities
  berlin = City.find_by_name "Berlin"
  City.create(:name => "Berlin") unless berlin
  cologne = City.find_by_name "Cologne"
  City.create(:name => "Cologne") unless cologne
end

def add_city_to_single_events
  c = City.find_by_name "Cologne"
  SingleEvent.all.each do |se|
    se.city_id = c.id
    se.save!
  end
end