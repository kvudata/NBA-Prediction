class Game < ActiveRecord::Base
	validates :play_date, :presence => true
	validates_presence_of :winner_id
	has_and_belongs_to_many :teams, :uniq => true
	has_one :winner, :class_name => :Team

	# convenience method which creates a game between the 2 given teams
	def create_game(team1, team2, winner)
		if winner == 0
		end
	end
end
