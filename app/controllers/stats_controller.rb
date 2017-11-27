require 'csv'

class StatsController < ApplicationController
  def overall

    @transports_per_team = []

    # @transports_per_team = Team.all.map do |team|
    #  {name: team.name, data: ElevatorState.where(team_id: team.id).pluck(:round_id, :total_transported)}
    # end
  end

  def simulator
    @round_id = params[:round_id].to_i || Round.minimum(:id)
    return unless Round.exists?(@round_id)

    state_data = Round.find(@round_id).building_state.state_object
    floors = state_data.floors
    elevators = state_data.elevators

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
      format.csv { send_data floor_states_csv, filename: "floors-#{Date.today}.csv" }
    end
  end

  def elevator_states
    respond_to do |format|
      format.csv { send_data elevator_states_csv, filename: "floors-#{Date.today}.csv" }
    end
  end

  private

  def floor_states_csv
    CSV.generate do |csv|
      csv << ['Round ID', 'Team ID', 'Current Floor', 'Total Transported']
      Round.all.each do |round|
        round.elevator_states.each do |es|
          csv << [round.id, es.team_id, es.current_level, es.total_transported]
        end
      end
    end
  end

  def elevator_states_csv
    CSV.generate do |csv|
      csv << ['Round ID', 'Current Number', 'People Waiting']
      Round.all.each do |round|
        round.elevator_states.each do |es|
          csv << [round.id, es.team_id, es.current_level, es.total_transported]
        end
      end
    end
  end
end