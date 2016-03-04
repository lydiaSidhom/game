class AddStartLatToErrand < ActiveRecord::Migration
  def change
    add_column :errands, :start_lat, :decimal
  end
end
