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

  def persist_state(building)
    round = Round.create!
    BuildingState.create!(round: round,
                          state_data: {
                            elevators: building.elevators.map { |elevator|
                              {
                                floor_number: elevator.floor_number,
                                people_carrying: elevator.people.count,
                                people_transported: elevator.statistics
                              }
                            },
                            floors: building.floors.map { |floor|
                              {
                                people_waiting: floor.people.count
                              }
                            }
                          })
  end

  def play_rounds
    LeanElevators.run do |building, _tick_number|
      persist_state(building)
      ActionCable.server.broadcast('live_stats_channel', message: "#{building}  #{_tick_number}")
    end
  end

  private

  def configure_rounds
    LeanElevators.configure do |config|
      config.building_size = 10
      config.net_deciders = @teams.map {|team| team.decider_app.dsn }
      config.tick_limit = 100
      config.decider_timeout = 0.3
      config.round_delay = 0
    end
  end
end
