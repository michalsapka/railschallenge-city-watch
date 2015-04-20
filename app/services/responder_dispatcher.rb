# Sends Responders to Emergency based on Severity
class ResponderDispatcher
  def initialize(emergency)
    @emergency = emergency
    @severity = {
      police: emergency.police_severity,
      medical: emergency.medical_severity,
      fire: emergency.fire_severity
    }
    dispatch_for(:police) if @severity[:police] > 0
    dispatch_for(:medical) if @severity[:medical] > 0
    dispatch_for(:fire) if @severity[:fire] > 0

    emergency.update(unresolved: count_unresolved)
  end

  private

  def dispatch_for(emergency_type)
    responder = Responder.next_avalible_for(emergency_type.capitalize, @severity[emergency_type]).first
    return unless responder
    responder.dispatch_to @emergency
    @severity[emergency_type] -= responder.capacity
    dispatch_for emergency_type if @severity[emergency_type.to_sym] > 0
  end

  def count_unresolved
    @severity[:police] + @severity[:medical] + @severity[:fire]
  end
end
