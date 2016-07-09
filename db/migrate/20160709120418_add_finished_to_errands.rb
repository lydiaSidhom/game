class AddFinishedToErrands < ActiveRecord::Migration
  def change
    add_column :errands, :finished, :boolean, :default => false
  end
end
