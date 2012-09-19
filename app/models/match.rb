class Match < ActiveRecord::Base
  attr_accessible :next, :round, :team1, :team2, :winner, :schedule, :bracket
  has_one :left_team, :class_name => "Team", :foreign_key => "team1"
  has_one :right_team, :class_name => "Team", :foreign_key => "team2"
  has_one :win_team, :class_name => "Team", :foreign_key => "winner"
  has_one :next_match, :class_name => "Match", :foreign_key => "next"

  validates :bracket, :inclusion => { 
    :in => %w(serious serious_wildcard fun fun_wildcard doubles doubles_wildcard), 
    :message => "%{value} is not a valid bracket" }

end
