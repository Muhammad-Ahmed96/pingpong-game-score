class Game < ActiveRecord::Base
  belongs_to :player_1, class_name: 'User'
  belongs_to :player_2, class_name: 'User'

  validates_presence_of :player_1, :player_2, :player_1_score, :player_2_score, :date_played

  def other_player(u)
    other_player = u == player_2 ? player_1 : player_2
    other_player.name.to_s.titleize rescue other_player.email.split("@").first.titleize
  end

  def scores(u)
    if u == player_1
      return "#{player_1_score}-#{player_2_score}"
    else
      return "#{player_2_score}-#{player_1_score}"
    end
  end

  def game_result(u)
    u == (player_1_score > player_2_score ? player_1 : player_2) ? 'W' : 'L'
  end

end
