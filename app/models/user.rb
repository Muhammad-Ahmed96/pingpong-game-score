class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :trackable, :validatable

  def games
    Game.where('player_1_id = ? OR player_2_id = ?', self.id, self.id)
  end

  def played
    # ToDo: May not be efficient long term. Check later.
    games.count
  end

end
