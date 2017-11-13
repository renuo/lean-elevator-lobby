class AddCarryingToElevatorState < ActiveRecord::Migration[5.1]
  def change
    add_column :elevator_states, :carrying, :integer
  end
end
