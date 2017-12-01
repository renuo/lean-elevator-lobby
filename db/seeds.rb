User.create!(email: ENV['ADMIN_EMAIL'], password: ENV['ADMIN_PASSWORD'])

['Gryffindor', 'Hufflepuff', 'Ravenclaw', 'Slytherin'].each do |team|
  user = User.create!(email: "#{team.downcase}@example.com", password: '12345678')
  Team.create!(name: team, users: [user], repository: "renuo/lean-elevators-#{team.downcase}")
end
