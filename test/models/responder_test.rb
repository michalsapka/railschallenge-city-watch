# == Schema Information
#
# Table name: responders
#
#  id             :integer          not null, primary key
#  type           :string
#  name           :string
#  capacity       :integer
#  emergency_code :string
#  on_duty        :boolean
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require 'test_helper'

class ResponderTest < ActiveSupport::TestCase
end
