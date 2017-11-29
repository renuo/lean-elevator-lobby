class GameController < ApplicationController
  def index
    @rounds_played = Round.count
    @game_config = game_config
  end

  def start
    Redis.current.set('game_state', 'running')
    game_config = setup_option_params.to_hash.symbolize_keys
    store_game_config_to_session(game_config)
    GameJob.perform_later(game_config)
    redirect_to game_index_path
  end

  def stop
    Redis.current.set('game_state', 'stopped')
    redirect_to game_index_path
  end

  def setup_option_params
    params.require(:start_with_game_config).permit(:building_size, :decider_timeout, :round_delay, :round_limit)
  end

  private

  def game_config
    return session[:game_config].symbolize_keys if session[:game_config]
    PlayMasterService.default_setup_options
  end

  def store_game_config_to_session(game_config)
    session[:game_config] = game_config
  end
end
