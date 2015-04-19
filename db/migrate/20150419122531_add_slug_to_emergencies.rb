class AddSlugToEmergencies < ActiveRecord::Migration
  def change
    add_column :emergencies, :slug, :string
  end
end
