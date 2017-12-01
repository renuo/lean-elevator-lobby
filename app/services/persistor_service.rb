class PersistorService
  def initialize
    CSV.open(floors_csv_path, 'wb') do |csv|
      csv << ['Round ID', 'Floor Number', 'People Waiting']
    end

    CSV.open(elevators_csv_path, 'wb') do |csv|
      csv << ['Round ID', 'Elevator Number', 'Current Floor', 'People Carrying']
    end
  end

  def store_state(building)
    persist_to_db(building)
    persist_to_csv(building)
  end

  private

  def persist_to_db(building)
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

  def persist_to_csv(building)
    round_id = Round.last.id

    append_to_floors(round_id, building)
    append_to_elevators(round_id, building)
  end

  def append_to_floors(round_number, building)
    CSV.open(floors_csv_path, 'a+') do |csv|
      building.floors.each_with_index do |floor, i|
        csv << [round_number, i, floor.people.count]
      end
    end
  end

  def append_to_elevators(round_number, building)
    CSV.open(elevators_csv_path, 'a+') do |csv|
      building.elevators.each_with_index do |elevator, i|
        csv << [round_number, i, elevator.floor_number, elevator.people.count]
      end
    end
  end

  def floors_csv_path
    Rails.root.join('tmp', 'all_floors_per_round.csv')
  end

  def elevators_csv_path
    Rails.root.join('tmp', 'all_elevators_per_round.csv')
  end
end
