class AddCityToBox < ActiveRecord::Migration
  def change
    add_column :boxes, :city_id, :integer
  end
end
