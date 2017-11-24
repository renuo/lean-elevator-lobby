class TeamSetupService
  def initialize(team)
    @team = team
  end

  def run
    app = HerokuService.new.create_app(random_app_name)
    DeciderApp.create!(name: app['name'], web_url: app['web_url'], git_url: app['git_url'], team: @team)
  end

  private

  def random_app_name
    "lec-#{SecureRandom.hex(12)}"
  end
end
