class CreateResponders < ActiveRecord::Migration
  def change
    create_table :responders do |t|
      t.string :type, null: false
      t.string :name, null: false
      t.integer :capacity, null: false, unique: true
      t.string :emergency_code
      t.boolean :on_duty

      t.timestamps null: false
    end
  end
end
