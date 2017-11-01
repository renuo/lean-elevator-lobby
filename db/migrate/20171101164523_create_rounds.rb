class CreateRounds < ActiveRecord::Migration[5.1]
  def change
    create_table :rounds do |t|
      t.timestamps
    end

    add_reference :elevator_states, :round, foreign_key: true
  end
end
