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

ActiveRecord::Schema.define(version: 20131124070123) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "gene_relations", force: true do |t|
    t.integer  "gene_id"
    t.integer  "interaction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gene_relations", ["gene_id"], name: "index_gene_relations_on_gene_id", using: :btree
  add_index "gene_relations", ["interaction_id"], name: "index_gene_relations_on_interaction_id", using: :btree

  create_table "genes", force: true do |t|
    t.string   "name"
    t.float    "bone"
    t.float    "cancer"
    t.float    "cardiovascular"
    t.float    "connective_tissue"
    t.float    "dermatological"
    t.float    "ear_nose_throat"
    t.float    "endocrine"
    t.float    "gastrointestinal"
    t.float    "hematological"
    t.float    "immunological"
    t.float    "metabolic"
    t.float    "muscular"
    t.float    "neurological"
    t.float    "nutritional"
    t.float    "ophthamological"
    t.float    "psychiatric"
    t.float    "renal"
    t.float    "respiratory"
    t.float    "skeletal"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interactions", force: true do |t|
    t.string   "name"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
