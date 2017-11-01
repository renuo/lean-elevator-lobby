class PlayMasterService
  def initialize(teams)
    @teams = teams
  end

  def run
    push_newest_to_heroku
    play_rounds(10_000)
  end

  def play_rounds(num_of_rounds)
    # code here
  end

  private
  def push_newest_to_heroku
    # code here
    @teams.each do |team|
      # system `git push heroku master` # for @team.respository
    end
    @dsn = @team.id
  end
  
  
end
