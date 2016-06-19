class AddCurrentToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :current, :boolean, :default => false
  end
end
