class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :crypted_password, null: false
      t.string :salt, null: false

      t.timestamps null: false
    end
  end
end
