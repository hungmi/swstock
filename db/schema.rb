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

ActiveRecord::Schema.define(version: 20150818145826) do

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

  create_table "orders", force: :cascade do |t|
    t.string   "picnum"
    t.string   "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stages", force: :cascade do |t|
    t.text     "sourcing_type"
    t.text     "order_date"
    t.text     "customer"
    t.text     "material_spec"
    t.text     "order_amount"
    t.text     "item_type"
    t.text     "picnum"
    t.text     "stage_amount"
    t.text     "stage_factory"
    t.text     "stage_date"
    t.text     "estimated_date"
    t.text     "note"
    t.text     "finish_date"
    t.text     "finished"
    t.text     "broken"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

end
