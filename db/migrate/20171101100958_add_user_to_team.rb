class AddUserToTeam < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :user, :reference, foreign_key: true, null: false
  end
end
