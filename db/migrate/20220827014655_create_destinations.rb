class CreateDestinations < ActiveRecord::Migration[7.0]
  def change
    create_table :destinations do |t|
      t.string :name, null: false
      t.string :state, null: false, default: 'California'
      t.string :city, null: false
      t.string :destination_type
      t.text   :description

      t.timestamps null: false
    end
  end
end
