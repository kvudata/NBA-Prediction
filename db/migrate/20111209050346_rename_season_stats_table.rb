class RenameSeasonStatsTable < ActiveRecord::Migration
  def up
	  rename_table :season_stats, :game_stats
  end

  def down
	  rename_table :game_stats, :season_stats
  end
end
