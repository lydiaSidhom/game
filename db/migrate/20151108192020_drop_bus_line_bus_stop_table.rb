class DropBusLineBusStopTable < ActiveRecord::Migration
  def up
    drop_table :bus_lines_bus_stops
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end

end
