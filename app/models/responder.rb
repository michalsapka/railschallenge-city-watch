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

  def self.capacity
    all.group_by(&:type).map do |r,v|
      eval("{#{r}: v.map(&:capacity)}")
    end

    # .group_by(&:type).map do |r,v|
    # p r
    # p v
    # end
  end

  private

  def assign_slug
    self.slug = self.name.parameterize
  end
end
