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
#

require "test_helper"

class EmergencyTest < ActiveSupport::TestCase

  def emergency
    @emergency ||= Emergency.new
  end

  def test_valid
    assert emergency.valid?
  end

end
