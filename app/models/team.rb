class Team < ApplicationRecord
  validates :repository, presence: true
  has_many :users
end
