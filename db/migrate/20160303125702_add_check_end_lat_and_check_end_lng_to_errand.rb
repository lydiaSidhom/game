class AddCheckEndLatAndCheckEndLngToErrand < ActiveRecord::Migration
  def change
    add_column :errands, :check_end_lat, :decimal
    add_column :errands, :check_end_lng, :decimal
  end
end
