class Team < ApplicationRecord
  validates :repository, presence: true
  has_many :users
  has_one :decider_app
end
