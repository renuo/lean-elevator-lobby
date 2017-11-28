require 'lean_elevators'

class PlayMasterService
  def initialize(teams, options = {})
    @teams = teams
    raise 'Not enough Heroku apps' unless @teams.all?(&:decider_app)
    @options = default_setup_options.merge(options)
    configure_business_logic
  end

  def play_rounds
    LeanElevators.run do |building, _tick_number|
      persist_state(building)
      ActionCable.server.broadcast('live_stats_channel', message: "#{building}  #{_tick_number}")
    end
  end

  def default_setup_options
    {
      round_limit: 10,
      building_size: 10,
      decider_timeout: 0.3,
      round_delay: 0
    }
  end

  private

  def configure_business_logic
    LeanElevators.configure do |config|
      config.net_deciders = @teams.map {|team| team.decider_app.dsn }
      config.building_size = @options[:building_size]
      config.tick_limit = @options[:round_limit]
      config.round_delay = @options[:round_delay]
      config.decider_timeout = @options[:decider_timeout]
    end
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
end
