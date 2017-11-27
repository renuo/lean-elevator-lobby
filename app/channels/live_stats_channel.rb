# frozen_string_literal: true

class LiveStatsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'live_stats_channel'
  end
end
