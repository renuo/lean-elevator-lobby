class TeamSetupService
  def initialize(team)
    @team = team
    @heroku = HerokuService.new
  end

  def run
    app = @heroku.create_app(random_app_name)
    DeciderApp.create!(name: app['name'], web_url: app['web_url'], git_url: app['git_url'], team: @team)
    push_newest_to_heroku
  end

  private

  def random_app_name
    "lec-#{SecureRandom.hex(12)}"
  end

  def push_newest_to_heroku
    build_url = @heroku.create_build(@team.decider_app.name, tarball_of_github_repo(team.repository))
    @team.update!(last_deployment: build_url)
  end

  def tarball_of_github_repo(repo)
    repo.gsub(/\.git$/, '/archive/master.tar.gz')
  end
end
