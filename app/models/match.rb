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

  def self.round(bracket, num)
    Match.where(:round => num, :bracket => bracket).first
  end
  def self.serious_round(num)
    Match.round("serious", num)
  end
  def self.fun_round(num)
    Match.round("fun", num)
  end
  def self.doubles_round(num)
    Match.round("doubles", num)
  end
  def self.serious_wildcard_round(num)
    Match.round("serious_wildcard", num)
  end
  def self.fun_wildcard_round(num)
    Match.round("fun_wildcard", num)
  end
  def self.doubles_wildcard_round(num)
    Match.round("doubles_wildcard", num)
  end
  def self.serious_final
    Match.where(:bracket => "serious_final")
  end
  def self.fun_final
    Match.where(:bracket => "fun_final")
  end
  def self.doubles_final
    Match.where(:bracket => "doubles_final")
  end

  def main_bracket
    bracket.split("_")[0]
  end

  def is_final
    return bracket =~ /_finals/
  end

  def is_wildcard
    return bracket =~ /_wildcard/
  end

  def next_winner_match
    Match.where(:round => winner_next, :bracket => bracket).first
  end

  def next_loser_match
    if !is_wildcard
      Match.where(:round => loser_next, :bracket => "#{bracket}_wildcard").first
    end
  end

  def has_team(team)
    return team.id == left_team.id || team.id == right_team.id
  end

  def get_other_team(team)
    if !has_team(team)
      raise "Team is not part of this match!"
    end
    if left_team != team
      return left_team
    else
      return right_team
    end
  end

  def set_team(team)
    if left_team.blank?
      self.left_team = team
    elsif right_team.blank?
      self.right_team = team
    else
      raise "This match is full! Can't add any more teams to it!"
    end
    return self
  end
end

