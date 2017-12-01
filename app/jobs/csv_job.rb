class CsvJob < ApplicationJob
  queue_as :default

  def perform

  end

  private

  def floor_states_csv_lines
    Enumerator.new do |y|
      y << CSV.generate_line(['Round ID', 'Floor Number', 'People Waiting'])

      Round.joins(:building_state).includes(:building_state).find_each.lazy.each do |round|
        round.building_state.floors.map.with_index do |floor, i|
          y << CSV.generate_line([round.id, i, floor.people_waiting])
        end
      end
    end
  end

  def elevator_states_csv_lines
    Enumerator.new do |y|
      y << CSV.generate_line(['Round ID', 'Elevator Number', 'Current Floor', 'People Carrying'])

      Round.joins(:building_state).includes(:building_state).find_each.lazy.each do |round|
        round.building_state.elevators.each_with_index do |elevator, i|
          y << CSV.generate_line([round.id, i, elevator.floor_number, elevator.people_carrying])
        end
      end
    end
  end
end
