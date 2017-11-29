class GameJob < ApplicationJob
  queue_as :default

  def perform(options = {})
    PlayMasterService.new(Team.select {|team| team.decider_app }, options)
  end
end
