class RemoveTimeStampsFromJoinTables < ActiveRecord::Migration
  def change
    remove_column :people_teams, :created_at
    remove_column :people_teams, :updated_at

    remove_column :pairings_people, :created_at
    remove_column :pairings_people, :updated_at
  end
end
