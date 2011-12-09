class AddTeamIdsToGames < ActiveRecord::Migration
  def change
    add_column :games, :team1_id, :integer
    add_column :games, :team2_id, :integer
  end
end
