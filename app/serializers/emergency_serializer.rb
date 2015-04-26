class EmergencySerializer < ActiveModel::Serializer
  attributes :code, :fire_severity, :medical_severity, :police_severity, :resolved_at, :responders, :full_response

  def responders
    object.responders.map(&:name)
  end

  def full_response
    object.severity == 0
  end
end
