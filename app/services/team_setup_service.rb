class TeamSetupService
  attr_reader :dsn

  def initialize(team)
    @team = team
  end

  def run
    create_heroku_app
    assign_dsn_to_team
  end

  private
  def create_heroku_app
    name = "lec-#{SecureRandom.hex(12)}"
    app = HerokuService.new.create_app(name)
    @dsn = app[:web_url]
  end

  def assign_dsn_to_team
    @team.update!(dsn: @dsn)
  end
end
