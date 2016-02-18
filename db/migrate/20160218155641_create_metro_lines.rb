class CreateMetroLines < ActiveRecord::Migration
  def change
    create_table :metro_lines do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
