class Emergency < ActiveRecord::Base
  attr_accessor :responders_called_off

  validates :code, presence: true, uniqueness: true
  validates :medical_severity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :fire_severity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :police_severity, presence: true, numericality: { greater_than_or_equal_to: 0 }

  after_create { ResponderDispatcher.new(self) }
  after_update :call_off_responders, if: :resolved?

  scope :resolved, -> { where(unresolved: 0) }

  has_many :responders

  private

  # Remove assosiation for all Responders assigned to this emergency
  def call_off_responders
    self.responders = []
    self.responders_called_off = true
    save!
  end

  # The emergency is resolved if resolved_at isn't nil and responders weren't just called of
  def resolved?
    !resolved_at.nil? && !responders_called_off
  end
end
