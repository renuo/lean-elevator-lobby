User.create!(email: ENV['ADMIN_EMAIL'], password: ENV['ADMIN_PASSWORD'])

['Gryffindor', 'Hufflepuff', 'Ravenclaw', 'Slytherin'].each do |team|
  user = User.create!(email: "#{team.downcase}@example.com", password: '12345678')
  Team.create!(name: team, users: [user], repository: "https://github.com/renuo/lean-elevators-#{team.downcase}.git")
end

[3.seconds.ago, 2.seconds.ago, 1.second.ago].each do |time|
  round = Round.new(created_at: time)

  Team.all.each do |team|
    round.elevator_states << ElevatorState.new(team: team, carrying: rand(0..6), total_transported: rand(50..200), current_level: rand(0..10))
  end

  round.save!
end
