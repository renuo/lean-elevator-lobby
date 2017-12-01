class PersistorService
  def self.store_state(building)
    round = Round.new
    BuildingState.create!(round: round,
                          state_data: {
                              elevators: building.elevators.map do |elevator|
                                {
                                    floor_number: elevator.floor_number,
                                    people_carrying: elevator.people.count,
                                    people_transported: elevator.statistics
                                }
                              end,
                              floors: building.floors.map do |floor|
                                {
                                    people_waiting: floor.people.count
                                }
                              end
                          })
  end
end
