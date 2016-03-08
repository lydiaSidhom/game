class ChangeDefaultValueOfScoreColumns < ActiveRecord::Migration
  def change
  	change_column :users, :score_time, :integer, :default => 0
  	change_column :users, :score_money, :integer, :default => 0
  	change_column :users, :score_pollution, :integer, :default => 0
  end
end
