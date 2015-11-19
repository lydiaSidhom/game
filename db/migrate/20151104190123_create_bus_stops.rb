class CreateBusStops < ActiveRecord::Migration
  def change
    create_table :bus_stops do |t|
      t.string :name
      t.string :location
      t.decimal :lat
      t.decimal :lng

      t.timestamps null: false
    end
  end
end
