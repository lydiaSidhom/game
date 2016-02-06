class ChangeDefaultOfColumn < ActiveRecord::Migration
  def change
  	change_column_default :errands, :done, from: true, to: false
  end
end
