class HomeController < ApplicationController
  def index
    @users = User.order(ranking: :desc)
  end

  def history
    # Someday we'll need pagination
    id = params[:id]
    user = User.find(id) rescue nil
    @games = user&.games&.order(date_played: :desc, created_at: :desc)
  end

  def log
    @game = Game.new
    @users = User.where.not(id: current_user.id)
  end

  def log_create
    @opponent = User.find(params[:opponent])

    @game = Game.new({
      player_1: current_user,
      player_2: @opponent,
      player_1_score: params[:game][:player_1_score],
      player_2_score: params[:game][:player_2_score],
      date_played: params[:game][:date_played]
    })
    if @game.save
      redirect_to :root, notice: "Game logged successfully"
    else
      # ToDo: Set values and proper error notifications
      redirect_to :log, alert: "Error logging the game: #{@game.errors.messages.to_yaml.gsub("-","")}"
    end
  end

  def delete_game
    game = Game.find(params[:id])
    game.destroy
    redirect_to game_history_path(current_user), alert: "Game deleted successfully"
  end

end
