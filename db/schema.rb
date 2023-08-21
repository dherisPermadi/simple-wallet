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

ActiveRecord::Schema[7.0].define(version: 2023_08_21_142320) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "oauth_access_grants", force: :cascade do |t|
    t.bigint "resource_owner_id", null: false
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri"
    t.string "scopes", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.index ["application_id"], name: "index_oauth_access_grants_on_application_id"
    t.index ["resource_owner_id"], name: "index_oauth_access_grants_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.bigint "resource_owner_id"
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.string "scopes"
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri"
    t.string "scopes", default: "", null: false
    t.boolean "confidential", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "transaction_details", force: :cascade do |t|
    t.bigint "wallet_id"
    t.string "transaction_type", null: false
    t.decimal "amount", precision: 8
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "taskable_type"
    t.bigint "taskable_id"
    t.index ["taskable_id", "taskable_type"], name: "index_transaction_details_on_taskable_id_and_taskable_type"
    t.index ["taskable_type", "taskable_id"], name: "index_transaction_details_on_taskable"
    t.index ["wallet_id"], name: "index_transaction_details_on_wallet_id"
  end

  create_table "transaction_reports", force: :cascade do |t|
    t.bigint "source_user_id"
    t.string "source_username"
    t.bigint "target_user_id"
    t.string "target_username"
    t.decimal "amount", precision: 20
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["source_user_id"], name: "index_transaction_reports_on_source_user_id"
    t.index ["target_user_id"], name: "index_transaction_reports_on_target_user_id"
  end

  create_table "transfer_reports", force: :cascade do |t|
    t.bigint "source_user_id"
    t.string "source_username"
    t.bigint "target_user_id"
    t.string "target_username"
    t.decimal "amount", precision: 15
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "transfer_type"
    t.index ["source_user_id"], name: "index_transfer_reports_on_source_user_id"
    t.index ["target_user_id"], name: "index_transfer_reports_on_target_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "wallet_deposits", force: :cascade do |t|
    t.bigint "wallet_id"
    t.decimal "amount", precision: 8
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["wallet_id"], name: "index_wallet_deposits_on_wallet_id"
  end

  create_table "wallet_transactions", force: :cascade do |t|
    t.string "sourceable_type"
    t.string "targetable_type"
    t.decimal "amount", precision: 15
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "source_user_id"
    t.bigint "target_user_id"
    t.index ["source_user_id"], name: "index_wallet_transactions_on_source_user_id"
    t.index ["target_user_id"], name: "index_wallet_transactions_on_target_user_id"
  end

  create_table "wallets", force: :cascade do |t|
    t.bigint "user_id"
    t.decimal "balance", precision: 20, default: "0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_wallets_on_user_id"
  end

  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
end
