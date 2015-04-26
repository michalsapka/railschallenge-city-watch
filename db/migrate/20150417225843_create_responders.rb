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

    add_index(:responders, :name)
    add_index(:responders, :type)
    add_index(:responders, :on_duty)
    add_index(:responders, :capacity)
  end
end
