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
    responders = all.group_by(&:type).flat_map do |rsp|
      total = izolate_responders rsp[1] { |h| true }
      avalible = izolate_responders rsp[1] { |h| h[:emergency_code] == nil }
      on_duty = izolate_responders rsp[1] { |h| h[:on_duty] == true }
      avalible_and_on_duty = izolate_responders rsp[1] do |h|
        h[:on_duty] == true && !h[:emergency_code]
      end
      [rsp[0].to_sym, [total, avalible, on_duty, avalible_and_on_duty]]
    end
    Hash[*responders]
  end

  # Izolates passed responders based on izolation
  # responders - array of responders
  # &izolation - block used for selector
  #
  # returns sum of capacity
  def self.izolate_responders(responders, &izolation)
    responders.select { |r| izolation.call(r) }.map { |h| h[:capacity] }.sum || 0
  end

  private

  def assign_slug
    self.slug = self.name.parameterize
  end
end

# all avalible on-duty aval+on-d
