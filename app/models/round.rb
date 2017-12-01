class Round < ApplicationRecord
  has_one :building_state, dependent: :destroy
end
