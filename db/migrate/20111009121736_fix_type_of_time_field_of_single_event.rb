class FixTypeOfTimeFieldOfSingleEvent < ActiveRecord::Migration
  def change
    remove_column :single_events, :time
    add_column :single_events, :time, :datetime
  end

end
