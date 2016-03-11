class AddGeocodedStartColumnToErrand < ActiveRecord::Migration
  def change
    add_column :errands, :geocoded_start, :string
  end
end
