# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(email: ENV['ADMIN_EMAIL'], password: ENV['ADMIN_PASSWORD'])

['Gryffindor', 'Hufflepuff', 'Ravenclaw', 'Slytherin'].each do |team|
  Team.create!(name: team, user: User.first, repository: "https://github.com/renuo/lean-elevators-#{team.downcase}.git")
end

[3.seconds.ago, 2.seconds.ago, 1.second.ago].each do |time|
  round = Round.new(created_at: time)

  Team.all.each do |team|
    round.elevator_states << ElevatorState.new(team: team,
                                               loaded: rand(0..3), unloaded: rand(0..3), carrying: rand(0..6),
                                               total_transported: rand(50..200),
                                               last_level: rand(0..10), current_level: rand(0..10))
  end

  round.save!
end
