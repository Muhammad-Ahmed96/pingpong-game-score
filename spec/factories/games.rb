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

FactoryGirl.define do
  factory :game do
    player_1
    player_2
    player_1_score { 21 }
    player_2_score { 19 }
    date_played { Faker::Date.between(2.days.ago, Date.today) }
  end
end
