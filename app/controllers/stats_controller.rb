class StatsController < ApplicationController
  def overall
    @transports_per_team = Team.all.map do |team|
      {name: team.name, data: ElevatorState.where(team_id: team.id).pluck(:round_id, :total_transported)}
    end
  end

  def rounds
    @team_performance_per_round = ElevatorState.all.order(id: :desc).group_by(&:round)
  end

  def simulator
    @round_id = params[:round_id].to_i || Round.minimum(:id)

    floor_count = 15
    states = ElevatorState.where(round_id: @round_id).order(:team_id)

    output = ''
    floor_count.downto(0) do |i|
      output << '█ '
      states.map do |state|
        output << if i == state.current_level
                    "[#{state.carrying}]"
                  elsif i == state.last_level
                    state.current_level - state.last_level > 0 ? ' ↑ ' : ' ↓ '
                  else
                    '   '
                  end
      end.join(' | ')
      output << " █\n"
    end

    @output = output
  end
end