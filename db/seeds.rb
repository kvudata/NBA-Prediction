# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'hpricot'
require 'open-uri'
require 'date'

# need to get teams, put in db
=begin
teams_page = Hpricot(open("http://www.basketball-reference.com/teams"))
links = teams_page.search("table#active a")
teams = []

links.each {|a|
	href = a.attributes['href']
	shortname = href[href.length-4,3]
	first_year = a.parent.following_siblings[1].inner_html.to_i
	teams << [shortname, first_year]
	Team.create(:short_name => shortname, :long_name => a.inner_html)
}
=end
teams = [
	[Team.create(:short_name => 'ATL', :long_name => 'Atlanta Hawks'), 1969],
	[Team.create(:short_name => 'BOS', :long_name => 'Boston Celtics'), 1947],
	[Team.create(:short_name => 'CHA', :long_name => 'Charlotte Bobcats'), 2005],
	[Team.create(:short_name => 'CHI', :long_name => 'Chicago Bulls'), 1967],
	[Team.create(:short_name => 'CLE', :long_name => 'Cleveland Cavaliers'), 1971],
	[Team.create(:short_name => 'DAL', :long_name => 'Dallas Mavericks'), 1981],
	[Team.create(:short_name => 'DEN', :long_name => 'Denver Nuggets'), 1977],
	[Team.create(:short_name => 'DET', :long_name => 'Detroit Pistons'), 1958],
	[Team.create(:short_name => 'GSW', :long_name => 'Golden State Warriors'), 1972],
	[Team.create(:short_name => 'HOU', :long_name => 'Houston Rockets'), 1972],
	[Team.create(:short_name => 'IND', :long_name => 'Indiana Pacers'), 1977],
	[Team.create(:short_name => 'LAC', :long_name => 'Los Angeles Clippers'), 1985],
	[Team.create(:short_name => 'LAL', :long_name => 'Los Angeles Lakers'), 1961],
	[Team.create(:short_name => 'MEM', :long_name => 'Memphis Grizzlies'), 2002],
	[Team.create(:short_name => 'MIA', :long_name => 'Miami Heat'), 1989],
	[Team.create(:short_name => 'MIL', :long_name => 'Milwaukee Bucks'), 1969],
	[Team.create(:short_name => 'MIN', :long_name => 'Minnesota Timberwolves'), 1990],
	[Team.create(:short_name => 'NJN', :long_name => 'New Jersey Nets'), 1978],
	[Team.create(:short_name => 'NOH', :long_name => 'New Orleans Hornets'), 2003],
	[Team.create(:short_name => 'NYK', :long_name => 'New York Knicks'), 1947],
	[Team.create(:short_name => 'OKC', :long_name => 'Oklahoma City Thunder'), 2009],
	[Team.create(:short_name => 'ORL', :long_name => 'Orlando Magic'), 1990],
	[Team.create(:short_name => 'PHI', :long_name => 'Philadelphia 76ers'), 1964],
	[Team.create(:short_name => 'PHO', :long_name => 'Phoenix Suns'), 1969],
	[Team.create(:short_name => 'POR', :long_name => 'Portland Trail Blazers'), 1971],
	[Team.create(:short_name => 'SAC', :long_name => 'Sacramento Kings'), 1986],
	[Team.create(:short_name => 'SAS', :long_name => 'San Antonio Spurs'), 1977],
	[Team.create(:short_name => 'TOR', :long_name => 'Toronto Raptors'), 1996],
	[Team.create(:short_name => 'UTA', :long_name => 'Utah Jazz'), 1980],
	[Team.create(:short_name => 'WAS', :long_name => 'Washington Wizards'), 1998]
]

first_year = 2009 # this is the first year where all these teams existed in the league


# now get schedules for each team
teams.each {|team|
	shortname = team[0].short_name
	curr_team = team[0]
	(first_year..2011).each {|year|
		schedule_url = "http://www.basketball-reference.com/teams/" + shortname + "/" + year.to_s + "_games.html"
		puts "Connecting to #{schedule_url}"
		schedule_doc = Hpricot(open(schedule_url))
		rows = schedule_doc.search("tbody > tr")

		ActiveRecord::Base.transaction do
			rows.each {|tr|
				if tr.class == "no_ranker thread"
					next
				end
				tds = tr.search("td")
				if tds.size > 0
					date = Date.parse(tds[1].attributes['csk'])
					away = (tds[2].html == '@')
					opp_team = Team.find_by_short_name(tds[3].attributes['csk'][0,3])
					win = (tds[4].inner_html == 'W')
					if win
						win_id = curr_team.id
					else
						win_id = opp_team.id
					end
					ot = (tds[5].inner_html == 'OT')
					pts = tds[6].inner_html.to_i
					opp_pts = tds[7].inner_html.to_i
					streak = tds[10].inner_html
					streak_type = streak[0]
					streak_num = streak[2...streak.length]

					# check if this game exists already
					g = Game.find_by_play_date_and_winner_id(date, win_id)
					if g.nil?
						# make GameStat's for both teams for this game
						game_url = tds[1].search('a')[0].attributes['href']
						game_url = "http://www.basketball-reference.com#{game_url}"
						puts "Connecting to #{game_url}"

						game_doc = Hpricot(open(game_url))
						adv_rows = game_doc.search("tbody > tr")

						adv_tds = adv_rows[0].search("td")
						team1_tds = game_doc.search("tfoot > tr")[0].search("td")
						team1_short_name = adv_tds[0].containers.first.inner_html
						team1_stats = GameStats.create(:pace => adv_tds[1].inner_html.to_f,
										 :efg => adv_tds[2].inner_html.to_f,
										 :tov_perc => adv_tds[3].inner_html.to_f,
										 :orb_perc => adv_tds[4].inner_html.to_f,
										 :ft_per_fga => adv_tds[5].inner_html.to_f,
										 :ortg => adv_tds[6].inner_html.to_f,
										 :fg => team1_tds[2].inner_html.to_i,
										 :fga => team1_tds[3].inner_html.to_i,
										 :fg_perc => team1_tds[4].inner_html.to_f,
										 :three_pt => team1_tds[5].inner_html.to_i,
										 :three_pta => team1_tds[6].inner_html.to_i,
										 :three_pt_perc => team1_tds[7].inner_html.to_f,
										 :ft => team1_tds[8].inner_html.to_i,
										 :fta => team1_tds[9].inner_html.to_i,
										 :ft_perc => team1_tds[10].inner_html.to_f,
										 :orb => team1_tds[11].inner_html.to_i,
										 :drb => team1_tds[12].inner_html.to_i,
										 :trb => team1_tds[13].inner_html.to_i,
										 :ast => team1_tds[14].inner_html.to_i,
										 :stl => team1_tds[15].inner_html.to_i,
										 :blk => team1_tds[16].inner_html.to_i,
										 :tov => team1_tds[17].inner_html.to_i,
										 :pf => team1_tds[18].inner_html.to_i,
										 :pts => team1_tds[19].inner_html.to_i
										)

						adv_tds = adv_rows[1].search("td")
						team2_tds = game_doc.search("tfoot > tr")[2].search("td")
						team2_short_name = adv_tds[0].containers.first.inner_html
						team2_stats = GameStats.create(:pace => adv_tds[1].inner_html.to_f,
												  :efg => adv_tds[2].inner_html.to_f,
												  :tov_perc => adv_tds[3].inner_html.to_f,
												  :orb_perc => adv_tds[4].inner_html.to_f,
												  :ft_per_fga => adv_tds[5].inner_html.to_f,
												  :ortg => adv_tds[6].inner_html.to_f,
												 :fg => team2_tds[2].inner_html.to_i,
												 :fga => team2_tds[3].inner_html.to_i,
												 :fg_perc => team2_tds[4].inner_html.to_f,
												 :three_pt => team2_tds[5].inner_html.to_i,
												 :three_pta => team2_tds[6].inner_html.to_i,
												 :three_pt_perc => team2_tds[7].inner_html.to_f,
												 :ft => team2_tds[8].inner_html.to_i,
												 :fta => team2_tds[9].inner_html.to_i,
												 :ft_perc => team2_tds[10].inner_html.to_f,
												 :orb => team2_tds[11].inner_html.to_i,
												 :drb => team2_tds[12].inner_html.to_i,
												 :trb => team2_tds[13].inner_html.to_i,
												 :ast => team2_tds[14].inner_html.to_i,
												 :stl => team2_tds[15].inner_html.to_i,
												 :blk => team2_tds[16].inner_html.to_i,
												 :tov => team2_tds[17].inner_html.to_i,
												 :pf => team2_tds[18].inner_html.to_i,
												 :pts => team2_tds[19].inner_html.to_i
												 )

						Game.create(:play_date => date,
									:winner_id => win_id,
									:home_team_id => (if away; opp_team.id; else; curr_team.id; end),
									:team1_id => curr_team.id,
									:team2_id => opp_team.id,
									:is_overtime => ot,
									:team1_stats_id => (if team1_short_name.eql? curr_team.short_name; team1_stats.id; else; team2_stats.id; end),
									:team2_stats_id => (if team1_short_name.eql? curr_team.short_name; team2_stats.id; else; team1_stats.id; end)
								   )
					end
				end
			}
		end
	}
}
