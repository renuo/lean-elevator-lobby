class TeamSetupService < DeployService
  def run
    app = @heroku.create_app(random_app_name)
    DeciderApp.create!(name: app['name'], web_url: app['web_url'], git_url: app['git_url'], team: @team)
    push_newest_to_heroku
  end

  private

  def random_app_name
    "lec-#{SecureRandom.hex(12)}"
  end
end
