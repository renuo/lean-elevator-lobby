App.live_stats = App.cable.subscriptions.create "LiveStatsChannel",
  received: (data) ->
    if $('#live-stats').length > 0
      $('#live-stats').html data.building
      $('#live-round').html "Round ##{data.tick_number}"
