class ResponderSerializer < ActiveModel::Serializer
  attributes :type, :name, :capacity, :on_duty, :emergency_code

  def emergency_code
    object.emergency.first.code if object.emergency
  end
end
