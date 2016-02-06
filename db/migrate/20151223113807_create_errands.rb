class CreateErrands < ActiveRecord::Migration
  def change
    create_table :errands do |t|
      t.integer :start_id
      t.integer :end_id
      t.string :choice
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
