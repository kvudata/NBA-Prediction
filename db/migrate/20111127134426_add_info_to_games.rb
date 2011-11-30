class AddInfoToGames < ActiveRecord::Migration
  def change
	  add_column :games, :home_team_id, :integer
	  add_column :games, :is_overtime, :boolean
	  add_column :games, :team1_pts, :integer
	  add_column :games, :team2_pts, :integer
  end
end
