class CreateSeasonStats < ActiveRecord::Migration
  def change
    create_table :season_stats do |t|
      t.float :pace_avg
      t.float :efg_avg
      t.float :tov_perc_avg
      t.float :orb_perc_avg
      t.float :ft_per_fga
      t.float :ortg_avg
      t.integer :fg_total
      t.integer :fga_total
      t.integer :three_pt_total
      t.integer :three_pta_total
      t.integer :ft_total
      t.integer :fta_total
      t.float :orb_avg
      t.float :drb_avg
      t.float :trb_avg
      t.float :ast_avg
      t.float :stl_avg
      t.float :blk_avg
      t.float :tov_avg
      t.float :pf_avg
      t.float :ppg

      t.timestamps
    end
  end
end
