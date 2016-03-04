class RemoveEndIdFromErrand < ActiveRecord::Migration
  def change
    remove_column :errands, :end_id, :integer
  end
end
