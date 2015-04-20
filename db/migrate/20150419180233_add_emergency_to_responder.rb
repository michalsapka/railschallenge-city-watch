class AddEmergencyToResponder < ActiveRecord::Migration
  def change
    add_reference :responders, :emergency, index: true
  end
end
