class AddOrganizationIdToPairing < ActiveRecord::Migration
  def change
      add_column :pairings, :organization_id, :integer
  end
end
