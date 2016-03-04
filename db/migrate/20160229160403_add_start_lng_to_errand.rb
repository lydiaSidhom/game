class AddStartLngToErrand < ActiveRecord::Migration
  def change
    add_column :errands, :start_lng, :decimal
  end
end
