# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_08_28_183908) do
  create_table "destinations", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.string "state", default: "California", null: false
    t.string "city", null: false
    t.string "destination_type"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "destinations_trips", charset: "utf8mb3", force: :cascade do |t|
    t.integer "trip_id"
    t.integer "destination_id"
  end

  create_table "trips", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "trip_type"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "trip_date"
    t.index ["user_id"], name: "index_trips_on_user_id"
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "crypted_password", null: false
    t.string "salt", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
