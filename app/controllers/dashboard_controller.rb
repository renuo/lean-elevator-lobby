class DashboardController < ApplicationController
  before_action :set_team

  def index; end

  private

  def set_team
    @team = current_user.team
  end
end
