class Team < ApplicationRecord
  validates :repository, presence: true
  belongs_to :user
end
