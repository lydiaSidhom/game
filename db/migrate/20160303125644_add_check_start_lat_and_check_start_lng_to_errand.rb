class AddCheckStartLatAndCheckStartLngToErrand < ActiveRecord::Migration
  def change
    add_column :errands, :check_start_lat, :decimal
    add_column :errands, :check_start_lng, :decimal
  end
end
