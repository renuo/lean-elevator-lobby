class ElevatorState < ApplicationRecord
  validates :loaded, :unloaded, :total_transported, :last_level, :current_level, presence: true

  belongs_to :team
end
