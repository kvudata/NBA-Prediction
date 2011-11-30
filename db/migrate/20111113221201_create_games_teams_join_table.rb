class CreateGamesTeamsJoinTable < ActiveRecord::Migration
  def up
	  create_table :games_teams, :id => false do |t|
		  t.references :game, :null => false
		  t.references :team, :null => false
	  end

	  add_index(:games_teams, [:game_id, :team_id], :unique=>true)
  end

  def down
	  drop_table :games_teams
  end
end
