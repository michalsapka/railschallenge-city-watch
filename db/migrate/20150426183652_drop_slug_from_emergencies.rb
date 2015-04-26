class DropSlugFromEmergencies < ActiveRecord::Migration
  def change
    remove_column :emergencies, :slug
  end
end
