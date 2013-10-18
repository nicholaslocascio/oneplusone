class CreatePairingsPeople < ActiveRecord::Migration
  def change
    create_table :pairings_people, id: false do |t|
      t.integer :person_id
      t.integer :pairing_id
      t.timestamps
    end
    add_index :pairings_people, [:pairing_id, :person_id]
  end
end
