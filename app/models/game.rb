class Game < ActiveRecord::Base
  belongs_to :player_1, class_name: 'User'
  belongs_to :player_2, class_name: 'User'

  validates_presence_of :player_1, :player_2, :player_1_score, :player_2_score, :date_played

end
