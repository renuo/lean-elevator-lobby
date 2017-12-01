require 'csv'

class StatsController < ApplicationController
  def overall
    # TODO: Show teams in graph, and what about autoupdate?
    graph_data = []

    building_states = BuildingState.last(1000)

    building_states.each do |state|
      state.elevators.each_with_index do |_elevator, i|
        graph_data[i] = { name: "Elevator #{i}", data: [] }
      end
    end

    building_states.each do |state|
      state.elevators.each_with_index do |elevator, i|
        graph_data[i][:data].push([state.round_id, elevator.people_transported])
      end
    end

    @transports_per_team = graph_data
  end

  def rounds
    @round_count = Round.count
  end

  def simulator
    @round_id = params[:round_id] ? params[:round_id].to_i : Round.minimum(:id)
    return unless Round.exists?(@round_id)

    round = Round.find(@round_id)
    floors = round.building_state.floors
    elevators = round.building_state.elevators

    @output = floors.map.with_index do |floor, level|
      chamber = elevators.map do |elevator|
        if level == elevator.floor_number
          "[#{elevator.people_carrying}]"
        else
          '   '
        end
      end.join(' | ')

      waiting_people = '웃' * floor.people_waiting

      "  █ #{chamber} █ #{waiting_people}"
    end.join("\n")
  end

  def floor_states
    respond_to do |format|
      format.csv { send_data floor_states_csv, filename: 'floors_per_round.csv' }
    end
  end

  def elevator_states
    respond_to do |format|
      format.csv { send_data elevator_states_csv, filename: 'elevators_per_round.csv' }
    end
  end

  private

  def floor_states_csv
    CSV.generate do |csv|
      csv << ['Round ID', 'Floor Number', 'People Waiting']
      Round.joins(:building_state).includes(:building_state).all.each do |round|
        round.building_state.floors.each_with_index do |floor, i|
          csv << [round.id, i, floor.people_waiting]
        end
      end
    end
  end

  def elevator_states_csv
    CSV.generate do |csv|
      csv << ['Round ID', 'Elevator Number', 'Current Floor', 'People Carrying']
      Round.joins(:building_state).includes(:building_state).all.each do |round|
        round.building_state.elevators.each_with_index do |elevator, i|
          csv << [round.id, i, elevator.floor_number, elevator.people_carrying]
        end
      end
    end
  end
end
