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

ActiveRecord::Schema.define(:version => 20111209000222) do

  create_table "games", :force => true do |t|
    t.date     "play_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "winner_id"
    t.integer  "home_team_id"
    t.boolean  "is_overtime"
    t.integer  "team1_pts"
    t.integer  "team2_pts"
    t.integer  "curr_season_stats_id"
    t.integer  "prev_season_stats_id"
    t.integer  "stats_since_09_id"
  end

  create_table "games_teams", :id => false, :force => true do |t|
    t.integer "game_id", :null => false
    t.integer "team_id", :null => false
  end

  add_index "games_teams", ["game_id", "team_id"], :name => "index_games_teams_on_game_id_and_team_id", :unique => true

  create_table "season_stats", :force => true do |t|
    t.float    "pace_avg"
    t.float    "efg_avg"
    t.float    "tov_perc_avg"
    t.float    "orb_perc_avg"
    t.float    "ft_per_fga"
    t.float    "ortg_avg"
    t.integer  "fg_total"
    t.integer  "fga_total"
    t.integer  "three_pt_total"
    t.integer  "three_pta_total"
    t.integer  "ft_total"
    t.integer  "fta_total"
    t.float    "orb_avg"
    t.float    "drb_avg"
    t.float    "trb_avg"
    t.float    "ast_avg"
    t.float    "stl_avg"
    t.float    "blk_avg"
    t.float    "tov_avg"
    t.float    "pf_avg"
    t.float    "ppg"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", :force => true do |t|
    t.string   "short_name"
    t.string   "long_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
