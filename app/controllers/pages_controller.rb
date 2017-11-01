class PagesController < ApplicationController
  def index
  end

  def stats
    @team_performance_per_round = ElevatorState.all.order(id: :desc).group_by(&:round)

    @transports_per_team = Team.all.map do |team|
      {name: team.name, data: ElevatorState.where(team_id: team.id).pluck(:round_id, :total_transported)}
    end
  end
end
