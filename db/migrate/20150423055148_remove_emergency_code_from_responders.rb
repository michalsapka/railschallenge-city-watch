class RemoveEmergencyCodeFromResponders < ActiveRecord::Migration
  def change
    remove_column :responders, :emergency_code
  end
end
