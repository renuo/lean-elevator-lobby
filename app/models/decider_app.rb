class DeciderApp < ApplicationRecord
  validates :name, :web_url, :git_url, presence: true
  belongs_to :team

  def dsn
    "#{web_url}decide"
  end

  def deploy_to_heroku
    build_url = HerokuService.new.create_build(name, team.tarball_of_github_repo)
    team.update!(last_deployment: build_url)
  end
end
