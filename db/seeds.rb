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

# now get schedules for each team
teams.each {|name_pair|
	shortname = name_pair[0]
	first_year = name_pair[1]
	curr_team = Team.where(:short_name => shortname)
	(first_year..2011).each {|year|
		schedule_url = "http://www.basketball-reference.com/teams/" + shortname + "/" + year + "_games.html"
		schedule_doc = Hpricot(open(schedule_url))
		rows = schedule_doc.search("tbody > tr")
		rows.each {|tr|
			if tr.class == "no_ranker thread"
				next
			end
			tds = tr.search("td")
			if tds.size > 0
				date = Date.parse(tds[1].attributes['csk'])
				away = (tds[2].html == '@')
				opp_team = Team.where(:short_name => tds[3].attributes['csk'][0,3])
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
				# TODO there should be a better way to check rather than watching for an exception
				begin
					g = Game.where(:play_date => date, :winner_id => win_id)
				rescue
					Game.create(:play_date => date,
								:winner_id => win_id,
								:home_team_id => (opp_team.id if away else curr_team.id),
								:teams => [curr_team, opp_team],
								:is_overtime => ot,
								:team1_pts => pts,
								:team2_pts => opp_pts
							   )
								end # TODO check this end matches correctly...
			end
		}
	}
}

db.close
