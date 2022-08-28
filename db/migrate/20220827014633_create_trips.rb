class CreateTrips < ActiveRecord::Migration[7.0]
  def change
    create_table :trips do |t|
      t.string :name
      t.string :trip_type
      t.belongs_to :user

      t.timestamps null: false
    end

    create_table :trips_destinations do |t|
      t.integer :trip_id
      t.integer :destination_id
    end

  end
end
