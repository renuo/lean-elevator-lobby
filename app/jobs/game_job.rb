class GameJob < ApplicationJob
  queue_as :default

  def perform
    service = PlayMasterService.new(Team.select {|team| team.decider_app })
    service.setup
    service.run
  end
end
