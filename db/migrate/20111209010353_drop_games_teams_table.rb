class DropGamesTeamsTable < ActiveRecord::Migration
  def up
	  drop_table :games_teams
  end

  def down
	  create_table "games_teams", :id => false do |t|
		t.integer "game_id", :null => false
		t.integer "team_id", :null => false
	  end
  end
end
