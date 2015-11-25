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

ActiveRecord::Schema.define(version: 20151125045442) do

  create_table "heatmap_grouping_points", force: true do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "count"
  end

  add_index "heatmap_grouping_points", ["latitude"], name: "index_heatmap_grouping_points_on_latitude"
  add_index "heatmap_grouping_points", ["longitude"], name: "index_heatmap_grouping_points_on_longitude"

  create_table "wifi_names", force: true do |t|
    t.string   "ssid"
    t.datetime "created_at", limit: 23
    t.datetime "updated_at", limit: 23
  end

  add_index "wifi_names", ["ssid"], name: "index_wifi_names_on_ssid"

  create_table "wifi_observations", force: true do |t|
    t.string   "type"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.integer  "wifi_service_id", limit: 4
    t.integer  "wifi_name_id",    limit: 4
    t.string   "raw_info_json",   limit: 2147483647
    t.datetime "created_at",      limit: 23
    t.datetime "updated_at",      limit: 23
  end

  add_index "wifi_observations", ["latitude"], name: "index_wifi_observations_on_latitude"
  add_index "wifi_observations", ["longitude"], name: "index_wifi_observations_on_longitude"
  add_index "wifi_observations", ["type"], name: "index_wifi_observations_on_type"
  add_index "wifi_observations", ["wifi_name_id"], name: "index_wifi_observations_on_wifi_name_id"
  add_index "wifi_observations", ["wifi_service_id"], name: "index_wifi_observations_on_wifi_service_id"

  create_table "wifi_services", force: true do |t|
    t.string   "bssid"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.datetime "created_at",                limit: 23
    t.datetime "updated_at",                limit: 23
    t.integer  "heatmap_grouping_point_id"
  end

  add_index "wifi_services", ["bssid"], name: "index_wifi_services_on_bssid", unique: true
  add_index "wifi_services", ["heatmap_grouping_point_id"], name: "index_wifi_services_on_heatmap_grouping_point_id"
  add_index "wifi_services", ["latitude"], name: "index_wifi_services_on_latitude"
  add_index "wifi_services", ["longitude"], name: "index_wifi_services_on_longitude"

end
