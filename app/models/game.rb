class Game < ActiveRecord::Base
	validates :play_date, :presence => true
	validates_presence_of :winner_id
	has_and_belongs_to_many :teams, :uniq => true

	def winner
		Team.find_by_id(@winner_id)
	end
end
