class AddLastDeploymentToTeam < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :last_deployment, :string
  end
end
