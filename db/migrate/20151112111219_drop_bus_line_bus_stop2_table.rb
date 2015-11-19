class DropBusLineBusStop2Table < ActiveRecord::Migration
  def up
    drop_table :bus_line_bus_stops
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end

end
