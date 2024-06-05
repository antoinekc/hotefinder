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

ActiveRecord::Schema[7.1].define(version: 2024_06_05_084621) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_missions", id: false, force: :cascade do |t|
    t.bigint "mission_id", null: false
    t.bigint "category_id", null: false
    t.index ["mission_id", "category_id"], name: "index_categories_missions_on_mission_id_and_category_id"
  end

  create_table "categories_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "category_id", null: false
  end

  create_table "cities", force: :cascade do |t|
    t.integer "postal_code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cities_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "city_id", null: false
    t.index ["user_id", "city_id"], name: "index_cities_users_on_user_id_and_city_id"
  end

  create_table "missions", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.date "start_date"
    t.date "end_date"
    t.bigint "host_id"
    t.bigint "owner_id"
    t.bigint "city_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_missions_on_city_id"
    t.index ["host_id"], name: "index_missions_on_host_id"
    t.index ["owner_id"], name: "index_missions_on_owner_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.date "birthdate"
    t.float "commission"
    t.boolean "is_host"
    t.boolean "is_owner"
    t.boolean "is_available"
    t.boolean "is_admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
