class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :email
      t.integer :organization_id
      t.integer :paired_count
      t.integer :unpaired_count
      t.timestamps
    end
    add_index :people, :organization_id
  end
end