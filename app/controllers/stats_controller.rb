require 'csv'

class StatsController < ApplicationController
  def overall_charts
    # TODO: Show teams in graph, and what about autoupdate?
    team_names = Team.all.order(:id).pluck(:name)
    graph_data = []

    building_states = BuildingState.last(200)

    building_states.each do |state|
      state.elevators.each_with_index do |_elevator, i|
        graph_data[i] = { name: team_names[i], data: [] }
      end
    end

    building_states.each do |state|
      state.elevators.each_with_index do |elevator, i|
        graph_data[i][:data].push([state.round_id, elevator.people_transported])
      end
    end

    render json: graph_data.chart_json
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
      floor_label = level.to_s.rjust(3)

      chamber = elevators.map do |elevator|
        if level == elevator.floor_number
          "[#{elevator.people_carrying}]"
        else
          '   '
        end
      end.join(' | ')

      waiting_people = '웃' * floor.people_waiting

      "#{floor_label} █ #{chamber} █ #{waiting_people}"
    end.reverse.join("\n")
  end

  def floor_states
    respond_to do |format|
      format.csv do
        set_csv_headers('floors_per_round.csv')
        self.response_body = floor_states_csv_lines(age_param.ago)
      end
    end
  end

  def elevator_states
    respond_to do |format|
      format.csv do
        set_csv_headers('elevators_per_round.csv')
        self.response_body = elevator_states_csv_lines(age_param.ago)
      end
    end
  end

  def set_csv_headers(filename)
    headers["X-Accel-Buffering"] = "no"
    headers["Cache-Control"] = "no-cache"
    headers["Content-Type"] = "text/csv; charset=utf-8"
    headers["Content-Disposition"] = %(attachment; filename="#{filename}")
    headers["Last-Modified"] = Time.zone.now.ctime.to_s
  end

  private

  def age_param
    (params[:age].to_i || 5).minutes
  end

  def floor_states_csv_lines(start_at)
    Enumerator.new do |y|
      y << CSV.generate_line(['Round ID', 'Floor Number', 'People Waiting'])

      Round.joins(:building_state).includes(:building_state)
          .where('rounds.created_at > ?', start_at).find_each.lazy.each do |round|
        round.building_state.floors.map.with_index do |floor, i|
          y << CSV.generate_line([round.id, i, floor.people_waiting])
        end
      end
    end
  end

  def elevator_states_csv_lines(start_at)
    Enumerator.new do |y|
      y << CSV.generate_line(['Round ID', 'Elevator Number', 'Current Floor', 'People Carrying'])

      Round.joins(:building_state).includes(:building_state)
          .where('rounds.created_at > ?', start_at).find_each.lazy.each do |round|
        round.building_state.elevators.each_with_index do |elevator, i|
          y << CSV.generate_line([round.id, i, elevator.floor_number, elevator.people_carrying])
        end
      end
    end
  end
end
