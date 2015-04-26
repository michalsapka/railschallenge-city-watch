class Responder < ActiveRecord::Base
  self.inheritance_column = :_type_disabled

  validates :capacity, presence: true, inclusion: { in: 1..5 }
  validates :type, presence: true
  validates :name, presence: true, uniqueness: true

  belongs_to :emergency

  # Sends Reponder to an emergency
  def dispatch_to(emergency)
    update(emergency: emergency)
  end

  # Returns the next avalible Responder for emergency_type that has the closest capacity to the required capacity
  def self.next_avalible_for(emergency_type, capacity)
    where(on_duty: true, emergency: nil, type: emergency_type).order("abs(#{capacity}-capacity)").limit(1)
  end

  # Returns an Hash of sums of capacity for responders
  #
  # key: kind of Emergency
  # total: sum of capacity from all responders
  # avalible: sum of capacity of responders that are avalible (not assigned to any emergency)
  # on_duty: sum of capacity of responders that are on duty
  # avalible_and_on_duty: sum of capacity of respoders that are both avalible and on duty
  def self.capacity
    counter = ResponderCapacityCounter.new(all)
    counter.counter
  end
end
