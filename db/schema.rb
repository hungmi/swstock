# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150819052121) do

  create_table "factories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string   "location"
    t.string   "item_type"
    t.string   "picnum"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "oldpicnum"
    t.text     "note"
    t.text     "finished"
    t.text     "unfinished"
    t.string   "customer"
  end

  create_table "procedures", force: :cascade do |t|
    t.string   "sourcing_type"
    t.string   "customer"
    t.string   "material_spec"
    t.date     "start_date"
    t.integer  "procedure_amount"
    t.integer  "workpiece_id"
    t.string   "aasm_state"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "procedures", ["workpiece_id"], name: "index_procedures_on_workpiece_id"

  create_table "stages", force: :cascade do |t|
    t.string   "factory_name"
    t.date     "arrival_date"
    t.date     "estimated_date"
    t.date     "finished_date"
    t.integer  "arrival_amount"
    t.integer  "finished_amount"
    t.integer  "broken_amount"
    t.text     "note"
    t.integer  "procedure_id"
    t.string   "aasm_state"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "stages", ["procedure_id"], name: "index_stages_on_procedure_id"

  create_table "workpieces", force: :cascade do |t|
    t.string   "wp_type"
    t.string   "picnum"
    t.string   "spec"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
