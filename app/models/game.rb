class Game < ActiveRecord::Base
  belongs_to :player_1, class_name: 'User'
  belongs_to :player_2, class_name: 'User'

  validates_presence_of :player_1, :player_2, :player_1_score, :player_2_score, :date_played

  validate :min_score
  validate :max_score
  validate :winning_difference

  after_create :set_elo_rankings

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
    u == (player_1_score > player_2_score ? player_1 : player_2) ? "W" : "L"
  end

  private

    def min_score
      if player_1_score < 21 and player_2_score < 21
        errors.add(:min_score, "The score needs to be min 21 for one of the players")
      end
    end

    def max_score
      if (player_1_score > 21 || player_2_score > 21) and (player_1_score - player_2_score).abs > 2
        errors.add(:max_score, "The score cannot be greater than 21 if the difference of the scores is greater that 2")
      end
    end

    def winning_difference
      if (player_1_score - player_2_score).abs < 2
        errors.add(:winning_difference, "You have to win or lose for more than 2 points")
      end
    end

    def set_elo_rankings
      # as taken from the example provided in the README
    end

end
