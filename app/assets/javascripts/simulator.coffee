$(document).ready ->
  if $('#simulator').length > 0
    $(document).keydown (e)->
      round = parseInt($('#simulator').data('round'), 10);
      roundMax = parseInt($('#simulator').data('round-max'), 10);
      switch e.which
        when 37
          window.location = 'simulator?round_id=' + (round-1) unless round == 1
          break;
        when 39
          window.location = 'simulator?round_id=' + (round+1) unless round==roundMax
          break;
  return
