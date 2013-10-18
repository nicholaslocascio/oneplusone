class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.integer :organization_id
      t.timestamps
    end
    add_index :teams, :organization_id 
  end
end
