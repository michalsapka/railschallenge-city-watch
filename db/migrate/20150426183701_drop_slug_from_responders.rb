class DropSlugFromResponders < ActiveRecord::Migration
  def change
    remove_column :responders, :slug
  end
end
