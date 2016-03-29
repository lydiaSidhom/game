class AddPretestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pretest, :string
  end
end
