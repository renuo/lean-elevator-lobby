class Team < ApplicationRecord
  validates :repository, presence: true
  validates_format_of :repository, with: /https?:\/\/(www\.)?github.com/i, message: 'Repository has to start with http://github.com'

  has_many :users
  has_one :decider_app
end
