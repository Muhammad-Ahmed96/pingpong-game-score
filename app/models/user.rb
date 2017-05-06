class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :trackable, :validatable
  has_many :games

  def name_or_email
    uname = name.to_s.length == 0 ? email.split("@").first : name rescue "¯\_(ツ)_/¯"
    uname.titleize
  end

  def games
    Game.where('player_1_id = ? OR player_2_id = ?', self.id, self.id)
  end

  def played
    # ToDo: May not be efficient long term. Check later.
    games.count
  end

end
