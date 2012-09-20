class Match < ActiveRecord::Base
  attr_accessible :next, :loser_next
  attr_accessible :team1, :team2, :winner
  attr_accessible :round, :schedule, :bracket

  belongs_to :left_team, :class_name => "Team", :foreign_key => "team1"
  belongs_to :right_team, :class_name => "Team", :foreign_key => "team2"
  belongs_to :win_team, :class_name => "Team", :foreign_key => "winner"
  belongs_to :next_winner_match, :class_name => "Match", :foreign_key => "next"
  belongs_to :next_loser_match, :class_name => "Match", :foreign_key => "loser_next"

  validates :bracket, :inclusion => { 
    :in => %w(serious serious_wildcard fun fun_wildcard doubles doubles_wildcard), 
    :message => "%{value} is not a valid bracket" }

  validates :round, :presence => true
end
