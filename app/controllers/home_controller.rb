class HomeController < ApplicationController
  def index
    @users = User.all
  end

  def history
  end

  def log
  end
end
