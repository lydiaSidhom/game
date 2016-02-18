class CreateMetroStops < ActiveRecord::Migration
  def change
    create_table :metro_stops do |t|
      t.string :name
      t.decimal :lat
      t.decimal :lng
      t.integer :location_id

      t.timestamps null: false
    end
  end
end
