class CreateEmergencies < ActiveRecord::Migration
  def change
    create_table :emergencies do |t|
      t.datetime :resolved_at
      t.string :code, null: false, unique: true
      t.integer :fire_severity, null: false
      t.integer :police_severity, null: false
      t.integer :medical_severity, null: false

      t.timestamps null: false
    end

    add_index(:emergencies, :code)
    add_index(:emergencies, :fire_severity)
    add_index(:emergencies, :medical_severity)
    add_index(:emergencies, :police_severity)
  end
end
