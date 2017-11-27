class RemoveFieldsFromElevatorState < ActiveRecord::Migration[5.1]
  def change
    remove_column :elevator_states, :loaded
    remove_column :elevator_states, :unloaded
    remove_column :elevator_states, :last_level
  end
end
