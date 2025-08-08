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

ActiveRecord::Schema[7.1].define(version: 2025_08_08_150754) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "detected_ingredients", force: :cascade do |t|
    t.string "name"
    t.boolean "is_custom"
    t.bigint "recipe_request_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_request_id"], name: "index_detected_ingredients_on_recipe_request_id"
  end

  create_table "pantry_items", force: :cascade do |t|
    t.string "name"
    t.bigint "recipe_request_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_custom"
    t.index ["recipe_request_id"], name: "index_pantry_items_on_recipe_request_id"
  end

  create_table "recipe_ingredients", force: :cascade do |t|
    t.bigint "detected_ingredient_id", null: false
    t.bigint "recipe_id", null: false
    t.float "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["detected_ingredient_id"], name: "index_recipe_ingredients_on_detected_ingredient_id"
    t.index ["recipe_id"], name: "index_recipe_ingredients_on_recipe_id"
  end

  create_table "recipe_requests", force: :cascade do |t|
    t.string "photo_url"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_recipe_requests_on_user_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "title"
    t.text "instructions"
    t.time "preparation_time"
    t.string "cuisine_type"
    t.bigint "recipe_request_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_request_id"], name: "index_recipes_on_recipe_request_id"
  end

  create_table "saved_recipes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "recipe_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_saved_recipes_on_recipe_id"
    t.index ["user_id"], name: "index_saved_recipes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "detected_ingredients", "recipe_requests"
  add_foreign_key "pantry_items", "recipe_requests"
  add_foreign_key "recipe_ingredients", "detected_ingredients"
  add_foreign_key "recipe_ingredients", "recipes"
  add_foreign_key "recipe_requests", "users"
  add_foreign_key "recipes", "recipe_requests"
  add_foreign_key "saved_recipes", "recipes"
  add_foreign_key "saved_recipes", "users"
end
