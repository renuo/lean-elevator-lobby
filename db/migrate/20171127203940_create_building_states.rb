class CreateBuildingStates < ActiveRecord::Migration[5.1]
  def change
    create_table :building_states do |t|
      t.belongs_to :round
      t.jsonb :state_data

      t.timestamps
    end

    drop_table :elevator_states
  end
end
