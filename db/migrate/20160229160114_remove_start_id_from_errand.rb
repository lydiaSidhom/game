class RemoveStartIdFromErrand < ActiveRecord::Migration
  def change
    remove_column :errands, :start_id, :integer
  end
end
