class AddTeamToElevatorState < ActiveRecord::Migration[5.1]
  def change
    add_reference :elevator_states, :team, foreign_key: true
  end
end
