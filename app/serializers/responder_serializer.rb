class ResponderSerializer < ActiveModel::Serializer
  attributes :type, :name, :capacity, :on_duty, :emergency_code
end
