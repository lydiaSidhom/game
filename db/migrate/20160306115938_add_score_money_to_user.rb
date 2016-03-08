class AddScoreMoneyToUser < ActiveRecord::Migration
  def change
    add_column :users, :score_money, :integer
  end
end
