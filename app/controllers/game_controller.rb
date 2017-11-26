class GameController < ApplicationController
  def index
    @rounds_played = Round.count
  end

  def start
    GameJob.perform_later
    redirect_to game_index_path
  end

  def stop
    redirect_to game_index_path
  end
end
