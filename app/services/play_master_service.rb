require 'lean_elevators'

class PlayMasterService
  def self.default_setup_options
    {
      building_size: 10,
      decider_timeout: 0.3,
      round_delay: 0,
      round_limit: 10
    }
  end

  def initialize(teams, options = {})
    @teams = teams
    raise 'Not enough Heroku apps' unless @teams.all?(&:decider_app)
    @options = PlayMasterService.default_setup_options.merge(options)
    configure_business_logic
    play_rounds
  end

  def play_rounds
    LeanElevators.run do |building, tick_number|
      persist_state(building)
      ActionCable.server.broadcast('live_stats_channel', building: building.to_s, tick_number: tick_number)
    end
  end

  private

  def configure_business_logic
    # Error handling for SocketError needed if net decider wasn't initialized yet
    LeanElevators.configure do |config|
      config.net_deciders = @teams.map { |team| team.decider_app.dsn }
      config.building_size = @options[:building_size].to_i
      config.decider_timeout = @options[:decider_timeout].to_f
      config.round_delay = @options[:round_delay].to_i
      config.tick_limit = @options[:round_limit].to_i
    end
  end

  def persist_state(building)
    round = Round.create!
    BuildingState.create!(round: round,
                          state_data: {
                            elevators: building.elevators.map do |elevator|
                              {
                                floor_number: elevator.floor_number,
                                people_carrying: elevator.people.count,
                                people_transported: elevator.statistics
                              }
                            end,
                            floors: building.floors.map do |floor|
                              {
                                people_waiting: floor.people.count
                              }
                            end
                          })
  end
end
