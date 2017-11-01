class CreateElevatorStates < ActiveRecord::Migration[5.1]
  def change
    create_table :elevator_states do |t|
      t.integer :loaded
      t.integer :unloaded
      t.integer :total_transported
      t.integer :last_level
      t.integer :current_level

      t.timestamps
    end
  end
end
