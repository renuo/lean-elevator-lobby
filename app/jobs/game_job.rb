class GameJob < ApplicationJob
  queue_as :default

  def perform(options = {})
    PlayMasterService.new(Team.select(&:decider_app), options)
  end
end
