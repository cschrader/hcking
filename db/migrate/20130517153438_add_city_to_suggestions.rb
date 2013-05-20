class AddCityToSuggestions < ActiveRecord::Migration
  def change
    add_column :suggestions, :city_id, :integer
  end
end
