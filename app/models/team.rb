class Team < ApplicationRecord
  validates :repository, presence: true
  validates_format_of :repository, with: /^[^\/].*(?<!\.git)$/i, message: 'Repository has to include only owner and name', multiline: true

  has_many :users
  has_one :decider_app


  def tarball_of_github_repo
    "#{extended_git_url}/archive/master.tar.gz"
  end

  def extended_git_url
    "https://github.com/#{repository}"
  end
end
