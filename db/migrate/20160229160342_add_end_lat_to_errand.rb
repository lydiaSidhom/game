class AddEndLatToErrand < ActiveRecord::Migration
  def change
    add_column :errands, :end_lat, :decimal
  end
end
