class AddEndLngToErrand < ActiveRecord::Migration
  def change
    add_column :errands, :end_lng, :decimal
  end
end
