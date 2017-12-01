class CreateDeciderApps < ActiveRecord::Migration[5.1]
  def change
    create_table :decider_apps do |t|
      t.string :name
      t.string :web_url
      t.string :git_url
      t.belongs_to :team

      t.timestamps
    end
  end
end
