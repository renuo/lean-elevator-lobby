class ElevatorState < ApplicationRecord
  validates :carrying, :total_transported, :current_level, presence: true

  belongs_to :team
  belongs_to :round
end
