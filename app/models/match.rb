class Match < ActiveRecord::Base
	attr_accessible :next, :round, :team1, :team2, :winner
	has_one :left_team, :class_name => "Team", :foreign_key => "team1"
	has_one :right_team, :class_name => "Team", :foreign_key => "team2"
	has_one :win_team, :class_name => "Team", :foreign_key => "winner"
	has_one :next_match, :class_name => "Match", :foreign_key => "next"
end
