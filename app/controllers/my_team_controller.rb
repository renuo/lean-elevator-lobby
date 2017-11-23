class MyTeamController < TeamsController
  after_action :join, only: :create

  def join
    @team = Team.find(params[:id])
    @team.users << current_user
    redirect_to user_root_path
  end

  def leave
    @team.users.delete(current_user)
    redirect_to user_root_path
  end

  private

  def set_team
    @team = current_user.team
  end
end
