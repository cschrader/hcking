class RenameColumnCityInVenues < ActiveRecord::Migration
  def up
    rename_column :venues, :city, :city_name
  end

  def down
    rename_column :venues, :city_name, :city
  end
end
