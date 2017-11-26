class Round < ApplicationRecord
  has_many :elevator_states, dependent: :destroy
end
