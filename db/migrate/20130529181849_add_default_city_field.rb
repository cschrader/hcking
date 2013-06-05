class AddDefaultCityField < ActiveRecord::Migration
  def up
    add_column :cities, :default, :boolean, :default => false
  end

  def down
    remove_column :cities, :default
  end
end
