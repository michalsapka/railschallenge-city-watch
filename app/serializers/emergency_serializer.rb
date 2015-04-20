# == Schema Information
#
# Table name: emergencies
#
#  id               :integer          not null, primary key
#  resolved_at      :datetime
#  code             :string
#  fire_severity    :integer
#  police_severity  :integer
#  medical_severity :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  slug             :string
#  unresolved       :integer
#

class EmergencySerializer < ActiveModel::Serializer
  attributes :code, :fire_severity, :medical_severity, :police_severity, :resolved_at, :responders, :full_response

  def responders
    object.responders.map(&:name)
  end

  def full_response
    object.unresolved == 0
  end

end
