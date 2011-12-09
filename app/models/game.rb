class Game < ActiveRecord::Base
	validates :play_date, :presence => true
	validates_presence_of :winner_id
end
