class Team < ActiveRecord::Base
	validates :short_name, :presence => true,
		:length => { :minimum => 3 },
		:uniqueness => true
	validates :long_name, :presence => true
end
