namespace :cities do

  desc "Update data from old structure"
  task :update_data => :environment do
    create_cities
    update_city_default_single_events
    update_city_default_blog_posts
    update_city_default_box
  end
end

def create_cities
  default_city = City.create(:name => 'Cologne',:default => true)
  City.create(:name => 'Berlin')

  default_city.default = true
  default_city.save!
end

def update_city_default_single_events
  city = City.default_city
  SingleEvent.all.each do |se|
    se.city = city
    se.save!
  end
end

def update_city_default_blog_posts
  city = City.default_city
  BlogPost.all.each do |bp|
    bp.city = city
    bp.save!
  end
end

def update_city_default_box
  city = City.default_city
  Box.all.each do |b|
    b.city = city
    b.save!
  end
end