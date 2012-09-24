module MatchesHelper

  def bracket_match(match, token_left, prev_left, token_right, prev_right)
    left_team = match.left_team.nil? ? "#{token_left}[#{prev_left}]" : match.left_team.name
    right_team = match.right_team.nil? ? "#{token_right}[#{prev_right}]" : match.right_team.name
    link_to "#{left_team} v #{right_team}", match
  end
end
