class HomeController < ApplicationController
  def index
    @users = User.order("ranking DESC")
  end

  def history
  end

  def log
  end
end
