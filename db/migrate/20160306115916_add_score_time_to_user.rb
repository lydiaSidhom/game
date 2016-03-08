class AddScoreTimeToUser < ActiveRecord::Migration
  def change
    add_column :users, :score_time, :integer
  end
end
