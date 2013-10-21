class AddWeekNumberToPairing < ActiveRecord::Migration
  def change
    add_column :pairings, :week_number, :integer
  end
end
