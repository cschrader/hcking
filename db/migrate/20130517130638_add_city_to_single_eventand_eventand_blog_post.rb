class AddCityToSingleEventandEventandBlogPost < ActiveRecord::Migration
  def change
    add_column :blog_posts, :city_id, :integer
    add_column :events, :city_id, :integer
    add_column :single_events, :city_id, :integer
  end
end
