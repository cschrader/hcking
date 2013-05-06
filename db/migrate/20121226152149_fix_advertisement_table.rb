class FixAdvertisementTable < ActiveRecord::Migration
  def change
    remove_column :advertisements, :from
    remove_column :advertisements, :to
    remove_column :advertisements, :calendar_week
    add_column :advertisements, :calendar_week, :integer
  end
end
