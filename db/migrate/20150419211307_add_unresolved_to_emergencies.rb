class AddUnresolvedToEmergencies < ActiveRecord::Migration
  def change
    add_column :emergencies, :unresolved, :integer
  end
end
