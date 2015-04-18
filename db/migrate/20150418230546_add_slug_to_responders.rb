class AddSlugToResponders < ActiveRecord::Migration
  def change
    add_column :responders, :slug, :string
  end
end
