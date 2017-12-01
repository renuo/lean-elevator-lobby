class DeciderApp < ApplicationRecord
  validates :name, :web_url, :git_url, presence: true
  belongs_to :team

  after_destroy :delete_heroku_app

  def dsn
    "#{web_url}decide"
  end

  def deploy_to_heroku
    build_url = HerokuService.new.create_build(name, team.tarball_of_github_repo)
    team.update!(last_deployment: build_url)
  end

  def delete_heroku_app
    HerokuService.new.delete_app(name)
  end
end
