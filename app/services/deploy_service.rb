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
    build_url = @heroku.create_build(@team.decider_app.name, tarball_of_github_repo(@team.repository))
    @team.update!(last_deployment: build_url)
  end

  def tarball_of_github_repo(repo)
    repo.gsub(/\.git$/, '/archive/master.tar.gz')
  end
end
