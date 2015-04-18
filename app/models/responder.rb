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
#
class Responder < ActiveRecord::Base
  self.inheritance_column = :_type_disabled


  validates :capacity, presence: true, inclusion: { in: 1..5 }
  validates :type, presence: true
  validates :name, presence: true, uniqueness: true

  before_save :assign_slug

  def to_json
    { emergency_code: emergency_code,
      type: type,
      name: name,
      capacity: capacity,
      on_duty: on_duty
      }
  end

  def assign_slug
    self.slug = self.name.parameterize
  end
end
