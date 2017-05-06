class HomeController < ApplicationController
  def index
    @users = User.order(ranking: :desc)
  end

  def history
  end

  def log
    @game = Game.new
    @users = User.where.not(id: current_user.id)
  end
end
