class FixGameColumns < ActiveRecord::Migration
  def up
	  remove_column :games, :team1_pts
	  remove_column :games, :team2_pts
	  remove_column :games, :pts
	  remove_column :games, :curr_season_stats_id
	  remove_column :games, :prev_season_stats_id
	  remove_column :games, :stats_since_09_id

	  add_column :games, :team1_stats_id, :integer
	  add_column :games, :team2_stats_id, :integer
  end

  def down
	  add_column :games, :team1_pts, :integer
	  add_column :games, :team2_pts, :integer
	  add_column :games, :pts, :integer
	  add_column :games, :curr_season_stats_id, :integer
	  add_column :games, :prev_season_stats_id, :integer
	  add_column :games, :stats_since_09_id, :integer

	  remove_column :games, :team1_stats_id
	  remove_column :games, :team2_stats_id
  end
end
