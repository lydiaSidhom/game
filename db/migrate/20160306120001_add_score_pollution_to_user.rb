class AddScorePollutionToUser < ActiveRecord::Migration
  def change
    add_column :users, :score_pollution, :integer
  end
end
