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

class Emergency < ActiveRecord::Base
  validates :code, presence: true, uniqueness: true
  validates :medical_severity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :fire_severity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :police_severity, presence: true, numericality: { greater_than_or_equal_to: 0 }

  before_save :assign_slug
  after_create { ResponderDispatcher.new(self) }
  before_update :call_off_responders, if: :resolved?

  has_many :responders

  def self.count_resolved
    where(unresolved: 0).count
  end

  private

  def assign_slug
    self.slug = code.parameterize
  end

  def call_off_responders
    responders.each(&:return_to_base)
  end

  def resolved?
    !resolved_at.nil?
  end
end
