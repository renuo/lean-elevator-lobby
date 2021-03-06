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

  delegate :elevators, to: :state_object

  delegate :floors, to: :state_object

  private

  def state_object
    JSON.parse(state_data.to_json, object_class: OpenStruct)
  end
end
