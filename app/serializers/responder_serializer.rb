# == Schema Information
#
# Table name: responders
#
#  id             :integer          not null, primary key
#  type           :string
#  name           :string
#  capacity       :integer
#  emergency_code :string
#  on_duty        :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  slug           :string
#  emergency_id   :integer
#

class ResponderSerializer < ActiveModel::Serializer
  attributes :type, :name, :capacity, :on_duty, :emergency_code
end
