class BuildingState < ApplicationRecord
  # state_data: {
  #     elevators: building.elevators.map { |elevator|
  #       {
  #           floor_number: elevator.floor_number,
  #           people_carrying: elevator.people.count,
  #           people_transported: elevator.statistics
  #       }
  #     },
  #     floors: building.floors.map { |floor|
  #       {
  #           people_waiting: floor.people.count
  #       }
  #     }
  # }
  validates :state_data, presence: true
  belongs_to :round

  def total_transported_per_elevator
    state_data.elevators.map(&:people_transported)
  end

  def state_object
    JSON.parse(state_data.to_json, object_class: OpenStruct)
  end
end
