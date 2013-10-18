class CreatePairings < ActiveRecord::Migration
  def change
    create_table :pairings do |t|
      t.integer :week_id
      t.timestamps
    end
    add_index(:pairings, :week_id)
  end
end
