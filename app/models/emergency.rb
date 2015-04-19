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

class Emergency < ActiveRecord::Base
  validates :code, presence: true, uniqueness: true
  validates :medical_severity, presence: true, numericality: { :greater_than_or_equal_to => 0 }
  validates :fire_severity, presence: true, numericality: { :greater_than_or_equal_to => 0 }
  validates :police_severity, presence: true, numericality: { :greater_than_or_equal_to => 0 }

  before_save :assign_slug

  private

  def assign_slug
    self.slug = self.code.parameterize
  end
end
