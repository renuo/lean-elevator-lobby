class TeamSetupService
  def initialize(team)
    @team = team
  end

  def run
    setup_heroku_app
  end

  private
  def setup_heroku_app
    # code here
    @dsn = @team.id
  end
end