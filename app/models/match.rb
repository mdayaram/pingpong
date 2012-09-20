class Match < ActiveRecord::Base
  attr_accessible :winner_next, :loser_next
  attr_accessible :team1, :team2, :winner
  attr_accessible :round, :schedule, :bracket

  belongs_to :left_team, :class_name => "Team", :foreign_key => "team1"
  belongs_to :right_team, :class_name => "Team", :foreign_key => "team2"
  belongs_to :win_team, :class_name => "Team", :foreign_key => "winner"

  validates :bracket, :inclusion => { 
    :in => %w(serious serious_wildcard serious_finals fun fun_wildcard fun_finals doubles doubles_wildcard doubles_finals),
    :message => "%{value} is not a valid bracket" }

  validates :round, :presence => true

  def next_winner_match
    Match.where(:round => winner_next, :bracket => bracket)
  end

  def next_loser_match
    unless @bracket =~ /_wildcard/
      Match.where(:round => loser_next, :bracket => "#{bracket}_wildcard")
    end
  end
end
