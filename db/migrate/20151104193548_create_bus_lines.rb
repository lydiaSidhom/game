class CreateBusLines < ActiveRecord::Migration
  def change
    create_table :bus_lines do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
