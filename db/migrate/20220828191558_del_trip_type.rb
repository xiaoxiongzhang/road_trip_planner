class DelTripType < ActiveRecord::Migration[7.0]
  def change
    remove_column :trips, :trip_type
  end
end
