class DeployService
  def initialize(team)
    @team = team
    @heroku = HerokuService.new
  end

  def run
    push_newest_to_heroku
  end

  private

  def push_newest_to_heroku
    build_url = @heroku.create_build(@team.decider_app.name, @team.tarball_of_github_repo)
    @team.update!(last_deployment: build_url)
  end
end
