class AddPasswordResetToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :password_reset_token, :string
    add_column :organizations, :password_reset_sent_at, :datetime
  end
end
