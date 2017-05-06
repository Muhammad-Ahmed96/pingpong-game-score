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

require 'test_helper'

class GameTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
