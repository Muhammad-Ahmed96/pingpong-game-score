# == Schema Information
#
# Table name: games
#
#  id             :integer          not null, primary key
#  player_1_id    :integer
#  player_2_id    :integer
#  player_1_score :integer
#  player_2_score :integer
#  date_played    :date
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Game < ActiveRecord::Base
  belongs_to :player_1, class_name: 'User'
  belongs_to :player_2, class_name: 'User'

  WINNING_SCORE  = 21
  MIN_SCORE_DIFF = 2

  validates_presence_of :player_1, :player_2, :player_1_score, :player_2_score, :date_played

  # validate :min_score
  # validate :max_score
  # validate :winning_difference

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
      if player_1_score < WINNING_SCORE and player_2_score < WINNING_SCORE
        errors.add(:min_score, "The score needs to be min 21 for one of the players")
      end
    end

    def max_score
      if (player_1_score > WINNING_SCORE || player_2_score > WINNING_SCORE) and (player_1_score - player_2_score).abs > MIN_SCORE_DIFF
        errors.add(:max_score, "The score cannot be greater than 21 if the difference of the scores is greater that 2")
      end
    end

    def winning_difference
      if (player_1_score - player_2_score).abs < MIN_SCORE_DIFF
        errors.add(:winning_difference, "You have to win or lose for more than 2 points")
      end
    end

    def set_elo_rankings(k_value=32)
      # As taken from the example provided in the README: https://github.com/rgho/elo.rb/blob/master/elo.rb

      # Assign actual individual results
      result = 0
      result = 1 if player_1_score > player_2_score
      player_1_result = result
      player_2_result = 1 - result

      # Calculate expected results
      player1_expectation = 1.0/(1+10**((player_2.ranking - player_1.ranking)/400.0)) #the .0 is important to force float operations!))
      player2_expectation = 1.0/(1+10**((player_1.ranking - player_2.ranking)/400.0))

      # Calculate new rankings
      player1_new_ranking = player_1.ranking + (k_value*(player_1_result - player1_expectation))
      player2_new_ranking = player_2.ranking + (k_value*(player_2_result- player2_expectation))

      # Not optional rounding
      player1_new_ranking = player1_new_ranking.round
      player2_new_ranking = player2_new_ranking.round

      # Set the new ranking and do so!
      player_1.update_attribute(:ranking, player1_new_ranking)
      player_2.update_attribute(:ranking, player2_new_ranking)
    end

    def won
      
    end

    def lost
    end

end
