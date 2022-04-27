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

ActiveRecord::Schema[7.0].define(version: 2022_04_27_080553) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "invoice_items", force: :cascade do |t|
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_changes", force: :cascade do |t|
    t.integer "old_amount"
    t.integer "new_amount"
    t.integer "job_status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "invoice_item_id", null: false
    t.index ["invoice_item_id"], name: "index_user_changes_on_invoice_item_id"
  end

  add_foreign_key "user_changes", "invoice_items"
  create_trigger("invoice_items_after_update_of_amount_row_tr", :generated => true, :compatibility => 7).
      on("invoice_items").
      after(:update).
      of(:amount) do
    <<-SQL_ACTIONS
INSERT INTO user_changes(id, old_amount, new_amount,  created_at, updated_at)
       VALUES(NEW.id, OLD.amount, NEW.amount, timezone('utc', now()),
        timezone('utc', now())) ON CONFLICT (id) DO UPDATE  SET created_at = excluded.created_at, 
        updated_at = excluded.updated_at,
        old_amount = excluded.old_amount, new_amount = excluded.new_amount;
    SQL_ACTIONS
  end

end
