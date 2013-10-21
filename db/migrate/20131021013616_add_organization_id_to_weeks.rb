class AddOrganizationIdToWeeks < ActiveRecord::Migration
  def change
    add_column :weeks, :organization_id, :integer
  end
end
