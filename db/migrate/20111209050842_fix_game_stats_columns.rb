class FixGameStatsColumns < ActiveRecord::Migration
  def change
	  rename_column :game_stats, :pace_avg, :pace
	  rename_column :game_stats, :efg_avg, :efg
	  rename_column :game_stats, :tov_perc_avg, :tov_perc
	  rename_column :game_stats, :orb_perc_avg, :orb_perc
	  rename_column :game_stats, :ortg_avg, :ortg
	  rename_column :game_stats, :fg_total, :fg
	  rename_column :game_stats, :fga_total, :fga
	  add_column :game_stats, :fg_perc, :float
	  rename_column :game_stats, :three_pt_total, :three_pt
	  rename_column :game_stats, :three_pta_total, :three_pta
	  add_column :game_stats, :three_pt_perc, :float
	  rename_column :game_stats, :ft_total, :ft
	  rename_column :game_stats, :fta_total, :fta
	  add_column :game_stats, :ft_perc, :float
	  remove_column :game_stats, :orb_avg
	  remove_column :game_stats, :drb_avg
	  remove_column :game_stats, :trb_avg
	  remove_column :game_stats, :ast_avg
	  remove_column :game_stats, :stl_avg
	  remove_column :game_stats, :blk_avg
	  remove_column :game_stats, :tov_avg
	  remove_column :game_stats, :pf_avg
	  remove_column :game_stats, :ppg

	  add_column :game_stats, :orb, :integer
	  add_column :game_stats, :drb, :integer
	  add_column :game_stats, :trb, :integer
	  add_column :game_stats, :ast, :integer
	  add_column :game_stats, :stl, :integer
	  add_column :game_stats, :blk, :integer
	  add_column :game_stats, :tov, :integer
	  add_column :game_stats, :pf, :integer
	  add_column :game_stats, :pts, :integer
  end
end
