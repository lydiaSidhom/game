class AddDoneToUserChallenges < ActiveRecord::Migration
  def change
  	add_column :user_challenges, :done, :boolean, :default => false
  end
end
