class InvertUserTeamRelation < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :team, foreign_key: true, null: true
    remove_reference :teams, :user
  end
end
