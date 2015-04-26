class DropUnresolvedFromEmergencies < ActiveRecord::Migration
  def change
    remove_column :emergencies, :unresolved
  end
end
