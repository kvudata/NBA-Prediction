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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111209050842) do

  create_table "game_stats", :force => true do |t|
    t.float    "pace"
    t.float    "efg"
    t.float    "tov_perc"
    t.float    "orb_perc"
    t.float    "ft_per_fga"
    t.float    "ortg"
    t.integer  "fg"
    t.integer  "fga"
    t.integer  "three_pt"
    t.integer  "three_pta"
    t.integer  "ft"
    t.integer  "fta"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "fg_perc"
    t.float    "three_pt_perc"
    t.float    "ft_perc"
    t.integer  "orb"
    t.integer  "drb"
    t.integer  "trb"
    t.integer  "ast"
    t.integer  "stl"
    t.integer  "blk"
    t.integer  "tov"
    t.integer  "pf"
    t.integer  "pts"
  end

  create_table "games", :force => true do |t|
    t.date     "play_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "winner_id"
    t.integer  "home_team_id"
    t.boolean  "is_overtime"
    t.integer  "team1_id"
    t.integer  "team2_id"
    t.integer  "team1_stats_id"
    t.integer  "team2_stats_id"
  end

  create_table "teams", :force => true do |t|
    t.string   "short_name"
    t.string   "long_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
