class AddStatsToGames < ActiveRecord::Migration
  def change
	  add_column :games, :curr_season_stats_id, :integer
	  add_column :games, :prev_season_stats_id, :integer
	  add_column :games, :stats_since_09_id, :integer
  end
end
