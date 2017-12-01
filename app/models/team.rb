class Team < ApplicationRecord
  validates :repository, presence: true
  validates :repository, format: { with: /^[^\/].*(?<!\.git)$/i,
                                   message: 'Repository has to include only owner and name',
                                   multiline: true }

  has_many :users, dependent: :nullify
  has_one :decider_app, dependent: :destroy

  def tarball_of_github_repo
    "#{extended_git_url}/archive/master.tar.gz"
  end

  def extended_git_url
    "https://github.com/#{repository}"
  end
end
