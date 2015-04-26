# Sends Responders to Emergency based on Severity
class ResponderDispatcher
  def initialize(emergency)
    @emergency = emergency
    @severity = {
      police: emergency.police_severity,
      medical: emergency.medical_severity,
      fire: emergency.fire_severity
    }

    dispatch_responders

    emergency.update(resolved_at: resolved_date,
                     fire_severity: @severity[:fire],
                     medical_severity: @severity[:medical],
                     police_severity: @severity[:police],
                     do_not_call_off: true)
  end

  private

  def dispatch_responders
    dispatch_for(:police) if @severity[:police] > 0
    dispatch_for(:medical) if @severity[:medical] > 0
    dispatch_for(:fire) if @severity[:fire] > 0
  end

  # Assign next avalible Responder with the closes capacicy for emergency_type to current emergency
  def dispatch_for(emergency_type)
    responder = Responder.next_avalible_for(emergency_type.capitalize, @severity[emergency_type]).first

    # return if there are no Responders left
    return unless responder

    responder.dispatch_to @emergency
    @severity[emergency_type] -= responder.capacity

    # dispatch next Responder if the emergency is still not resolved for current emergency_type
    dispatch_for emergency_type if @severity[emergency_type.to_sym] > 0
  end

  # Returns a number of remaining severities
  def count_unresolved
    @severity[:police] + @severity[:medical] + @severity[:fire]
  end

  # Returns current date if all severities are 0, or nil if not
  def resolved_date
    Time.zone.now  if count_unresolved == 0
  end
end
