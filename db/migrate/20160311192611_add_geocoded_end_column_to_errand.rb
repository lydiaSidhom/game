class AddGeocodedEndColumnToErrand < ActiveRecord::Migration
  def change
    add_column :errands, :geocoded_end, :string
  end
end
