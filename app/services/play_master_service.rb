require 'lean_elevators'

class PlayMasterService
  def initialize(teams)
    @teams = teams
    raise 'Not enough Heroku apps' unless @teams.all?(&:decider_app)
  end

  def setup
    configure_rounds
  end

  def run
    play_rounds
  end

  def persist_state(elevator, round, team)
    ElevatorState.create!(loaded: 0,
                          unloaded: 0,
                          total_transported: elevator.statistics,
                          last_level: 0,
                          current_level: elevator.floor_number,
                          carrying: elevator.people.count,
                          round: round,
                          team: team)
  end

  def play_rounds
    LeanElevators.run do |building, _tick_number|
      round = Round.create!
      building.elevators.each_with_index do |elevator, index|
        persist_state(elevator, round, @teams[index])
      end

      putc '.'
    end
  end

  private

  def configure_rounds
    LeanElevators.configure do |config|
      config.building_size = 10
      config.net_deciders = @teams.map {|team| team.decider_app.dsn }
      config.tick_limit = 10_000
      config.decider_timeout = 0.3
      config.round_delay = 0
    end
  end
end
