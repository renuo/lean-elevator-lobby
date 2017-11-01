class AddRepoToTeam < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :repository, :string
  end
end
