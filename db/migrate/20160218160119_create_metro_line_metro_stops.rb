class CreateMetroLineMetroStops < ActiveRecord::Migration
  def change
    create_table :metro_line_metro_stops do |t|
      t.integer :metro_line_id
      t.integer :metro_stop_id

      t.timestamps null: false
    end
  end
end
