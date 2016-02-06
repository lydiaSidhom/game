class ChangeDefaultOfColumn2 < ActiveRecord::Migration
  def change
  	change_column_default :errands, :done, false
  end
end
