module MatchesHelper

  def bracket_match(match, left_default, right_default)
    left_team = match.left_team.nil? ? left_default : match.left_team.name
    right_team = match.right_team.nil? ? right_default : match.right_team.name
    link_to "#{left_team} v #{right_team}", match
  end
end
