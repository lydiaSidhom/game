class AddColumnsToErrands < ActiveRecord::Migration
  def change
    add_column :errands, :check_start_time, :datetime
    add_column :errands, :check_end_time, :datetime
    add_column :errands, :done, :boolean
  end
end
