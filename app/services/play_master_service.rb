class PlayMasterService
  def initialize(teams)
    @teams = teams
    @heroku = HerokuService.new
  end

  def run
    push_newest_to_heroku
    configure_round
    play_rounds(10_000)
  end

  def persist_state(elevator)
    ElevatorState.create!(loaded: nil,
                          unloaded: nil,
                          total_transported: elevator.statistics,
                          last_level: nil,
                          current_level: elevator.floor_number)
  end

  def play_rounds(_num_of_rounds)
    LeanElevators.run do |building|
      building.elevators.each do |elevator|
        persist_state(elevator)
      end
    end
  end

  private

  def configure_round
    LeanElevators.configure do |config|
      config.building_size = 10
      config.net_deciders = @teams.map(&:dsn)
      config.tick_limit = 10_000
      config.decider_timeout = 0.3
      config.round_delay = 0
    end
  end

  def push_newest_to_heroku
    # code here
    @teams.each do |team|
      build_url = @heroku.create_build("lean-elevator-challenge-#{@team.id}", @team.dsn.gsub(/\.git$/, '/archive/master.tar.gz'))
      team.update!(last_deployment: build_url)
    end
  end
end
